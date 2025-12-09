#!/usr/bin/env ruby

require 'fileutils'
require 'open-uri'
require 'json'

OWNER = 'htsign'.freeze
REPO = 'my-vim-settings'.freeze
REF = 'master'.freeze

def fetch_and_write filename, subdirs = []
  path = File.expand_path((['~'] + subdirs + [filename]).join '/')
  open(path, 'w') do |f|
    url_base = "https://raw.githubusercontent.com/#{OWNER}/#{REPO}/refs/heads/#{REF}"
    f.write URI.open("#{url_base}/#{(subdirs + [filename]).join '/'}").read
  end
end

def expand_tracked_dir dir
  url = "https://api.github.com/repos/#{OWNER}/#{REPO}/contents/#{dir}?ref=#{REF}"
  entries = JSON.parse(URI.open(url).read)
  entries.each do |entry|
    case entry['type']
    when 'dir'
      expand_tracked_dir entry['path']
    when 'file'
      d, f = File.split entry['path']
      FileUtils.mkdir_p File.expand_path("~/#{d}")
      fetch_and_write f, [d]
    end
  end
end

fetch_and_write '.vimrc'

FileUtils.mkdir_p File.expand_path('~/.vim')
expand_tracked_dir '.vim'

Dir.chdir File.expand_path('~/.vim') do
  EXT_PACKAGES = [
    ['vim-jp/vimdoc-ja'],
    ['ap/vim-buftabline'],
    ['neoclide/coc.nvim', 'release'],
    ['Exafunction/windsurf.vim'],
    ['easymotion/vim-easymotion'],
    ['ctrlpvim/ctrlp.vim'],
    ['mattn/ctrlp-matchfuzzy'],
    ['itchyny/vim-cursorword'],
    ['kshenoy/vim-signature'],
    ['tpope/vim-surround'],
  ].freeze
  EXT_OPT_PACKAGES = [
    ['obcat/vim-hitspop'],
    ['nvim-treesitter/nvim-treesitter-textobjects', 'main'],
  ].freeze
  FTPLUGIN_PACKAGES = [
    ['sheerun/vim-polyglot'],
    ['mechatroner/rainbow_csv'],
    ['MTDL9/vim-log-highlighting'],
    ['plasticboy/vim-markdown'],
  ].freeze

  def install_packages packages, category, auto=true
    root = File.expand_path("~/.vim/pack/#{category}/#{auto ? 'start' : 'opt'}")
    FileUtils.mkdir_p root

    packages.each do |pkg, branch|
      author, name = pkg.split('/')
      dir = File.join root, name

      if Dir.exist? dir
        puts "\033[33mupdating #{author}/#{name}...\033[0m"

        branch ||= `git -C #{dir} remote show origin`.match(/^\s*HEAD branch: (.+)$/) { $1 }

        `git -C #{dir} fetch --depth=1 --prune`
        `git -C #{dir} reset --hard origin/#{branch}`
      else
        `git -C #{root} clone --depth=1 #{branch ? "-b #{branch}" : ''} https://github.com/#{pkg}.git`
      end
    end
  end
  install_packages EXT_PACKAGES, 'extensions'
  install_packages EXT_OPT_PACKAGES, 'extensions', false
  install_packages FTPLUGIN_PACKAGES, 'ftplugins'
end
