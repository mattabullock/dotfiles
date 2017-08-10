mv ~/dotfiles/.* ~/
mv ~/dotfiles/* ~/

sudo apt install ncurses-dev python-dev cmake

# install vim and all extras
git clone https://github.com/vim/vim.git
cd vim/src
make install

sudo apt -y install ctags

# install golang
curl https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz | sudo tar -C /usr/local -zx

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer --gocode-completer
