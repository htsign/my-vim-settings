#!/usr/bin/env ruby

require 'fileutils'
require 'open-uri'

PREFIX = 'https://gist.githubusercontent.com/htsign/c7b2817ffa2e4ce9f6646d07e998ab0f/raw'.freeze

def save file, url
  open(file, 'w') do |f|
    f.write URI.open(url).read
  end
end

save File.expand_path('~/.vimrc'), "#{PREFIX}/.vimrc"

FileUtils.mkdir_p File.expand_path('~/.vim')
save File.expand_path('~/.vim/keymap.vim'), "#{PREFIX}/keymap.vim"
save File.expand_path('~/.vim/easymotion.vim'), "#{PREFIX}/easymotion.vim"

Dir.chdir File.expand_path('~/.vim') do
  EXT_PACKAGES = [
    ['vim-jp/vimdoc-ja'],
    ['neoclide/coc.nvim', 'release'],
    ['easymotion/vim-easymotion'],
    ['itchyny/vim-cursorword'],
    ['tpope/vim-sleuth'],
    ['tpope/vim-surround'],
  ].freeze
  FTPLUGIN_PACKAGES = [
    ['mechatroner/rainbow_csv'],
    ['MTDL9/vim-log-highlighting'],
    ['plasticboy/vim-markdown'],
  ].freeze

  def install_packages packages, category
    root = File.expand_path("~/.vim/pack/#{category}/start")
    FileUtils.mkdir_p root

    packages.each do |pkg, branch|
      author, name = pkg.split('/')
      if Dir.exist? File.join(root, name)
        puts "updating #{name}..."
        `git -C #{root}/#{name} pull --ff-only`
      else
        `git -C #{root} clone #{branch ? "-b #{branch}" : ''} https://github.com/#{pkg}.git`
      end
    end
  end
  install_packages EXT_PACKAGES, 'extensions'
  install_packages FTPLUGIN_PACKAGES, 'ftplugins'
end
