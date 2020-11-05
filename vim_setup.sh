#!/usr/bin/env bash

mkdir -p ~/.vim
cd ~/.vim

PACKAGES=(
    'extensions/start/ neoclide/coc.nvim junegunn/fzf.vim easymotion/vim-easymotion tpope/vim-surround'
    'ftplugins/start/ mechatroner/rainbow_csv MTDL9/vim-log-highlighting plasticboy/vim-markdown'
)
for v in ${PATHS[@]}; do
    arr=(${v[@]})
    path=${arr[0]}
    
    mkdir -p "pack/$path"
    for id in ${arr[@]:1}; do
        git -C "pack/$path" clone $id
    done
done