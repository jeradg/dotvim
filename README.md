dotvim
=========

**Deprecated. I'm using Spacevim now. See [.SpaceVim.d](https://github.com/jeradg/.SpaceVim.d).**

(Instructions per http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/)

Installation:

    git clone git://github.com/jeradg/dotvim.git ~/.vim --recursive

Create symlinks:

    ln -s ~/.vim/.vimrc ~/.vimrc
    ln -s ~/.vim/.gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update
