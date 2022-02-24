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
    'vim-jp/vimdoc-ja',
    'prabirshrestha/vim-lsp',
    'mattn/vim-lsp-settings',
    'prabirshrestha/asyncomplete.vim',
    'prabirshrestha/asyncomplete-lsp.vim',
    'easymotion/vim-easymotion',
    'itchyny/vim-cursorword',
    'tpope/vim-surround',
  ].freeze
  FTPLUGIN_PACKAGES = [
    'mechatroner/rainbow_csv',
    'MTDL9/vim-log-highlighting',
    'plasticboy/vim-markdown',
  ].freeze

  def install_packages packages, category
    root = File.expand_path("~/.vim/pack/#{category}/start")
    packages.each do |pkg|
      author, name = pkg.split('/')
      if Dir.exist? File.join(root, name)
        puts "updating #{name}..."
        `git -C #{root}/#{name} pull --ff-only`
      else
        `git -C #{root} clone https://github.com/#{pkg}.git`
      end
    end
  end
  install_packages EXT_PACKAGES, 'extensions'
  install_packages FTPLUGIN_PACKAGES, 'ftplugins'
end