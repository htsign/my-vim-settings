@echo off
setlocal

cd %UserProfile%
mklink /d vimfiles .vim
