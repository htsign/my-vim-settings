#!/usr/bin/env bash

PREFIX="https://gist.githubusercontent.com/htsign/c7b2817ffa2e4ce9f6646d07e998ab0f/raw"

curl -L $PREFIX/.vimrc -o ~/.vimrc

mkdir -p ~/.vim
cd ~/.vim

curl -LO $PREFIX/keymap.vim
curl -LO $PREFIX/easymotion.vim

PACKAGES=(
    'extensions/start/ neoclide/coc.nvim junegunn/fzf.vim easymotion/vim-easymotion tpope/vim-surround'
    'ftplugins/start/ mechatroner/rainbow_csv MTDL9/vim-log-highlighting plasticboy/vim-markdown'
)
for v in "${PACKAGES[@]}"; do
    arr=(${v[@]})
    path=${arr[0]}
    
    mkdir -p "pack/$path"
    for id in ${arr[@]:1}; do
        name=${id#*/}
        if [ -d "pack/$path/$name" ]; then
            echo "updating $id ..."
            git -C "pack/$path/$name" pull --ff-only
        else
            git -C "pack/$path" clone "https://github.com/$id.git"
        fi
    done
done
