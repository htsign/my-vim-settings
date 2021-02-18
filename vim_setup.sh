#!/usr/bin/env bash

mkdir -p ~/.vim
cd ~/.vim

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
