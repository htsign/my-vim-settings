#!/usr/bin/env ruby

require 'fileutils'
require 'open-uri'

PREFIX = 'https://raw.githubusercontent.com/htsign/my-vim-settings/master'.freeze

def fetch_and_write filename, subdirs = []
  path = File.expand_path((['~'] + subdirs + [filename]).join '/')
  open(path, 'w') do |f|
    f.write URI.open("#{PREFIX}/#{filename}").read
  end
end

fetch_and_write '.vimrc'

FileUtils.mkdir_p File.expand_path('~/.vim')
fetch_and_write 'keymap.vim', ['.vim']
fetch_and_write 'codeium.vim', ['.vim']
fetch_and_write 'easymotion.vim', ['.vim']
fetch_and_write 'ctrlp.vim', ['.vim']

Dir.chdir File.expand_path('~/.vim') do
  EXT_PACKAGES = [
    ['vim-jp/vimdoc-ja'],
    ['neoclide/coc.nvim', 'release'],
    ['Exafunction/windsurf.vim'],
    ['easymotion/vim-easymotion'],
    ['ctrlpvim/ctrlp.vim'],
    ['mattn/ctrlp-matchfuzzy'],
    ['itchyny/vim-cursorword'],
    ['kshenoy/vim-signature'],
    ['tpope/vim-surround'],
  ].freeze
  FTPLUGIN_PACKAGES = [
    ['sheerun/vim-polyglot'],
    ['mechatroner/rainbow_csv'],
    ['MTDL9/vim-log-highlighting'],
    ['plasticboy/vim-markdown'],
  ].freeze

  def install_packages packages, category
    root = File.expand_path("~/.vim/pack/#{category}/start")
    FileUtils.mkdir_p root

    packages.each do |pkg, branch|
      author, name = pkg.split('/')
      dir = File.join root, name

      if Dir.exist? dir
        puts "\033[33mupdating #{author}/#{name}...\033[0m"

        branch ||= `git -C #{dir} remote show origin`.match(/^\s*HEAD branch: (.+)$/) { $1 }

        `git -C #{dir} fetch --prune`
        `git -C #{dir} reset --hard origin/#{branch}`
      else
        `git -C #{root} clone #{branch ? "-b #{branch}" : ''} https://github.com/#{pkg}.git`
      end
    end
  end
  install_packages EXT_PACKAGES, 'extensions'
  install_packages FTPLUGIN_PACKAGES, 'ftplugins'
end
