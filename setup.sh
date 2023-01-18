mv ~/dotfiles/.* ~/
mv ~/dotfiles/* ~/

sudo apt install ncurses-dev python-dev cmake

# install vim and all extras
git clone https://github.com/vim/vim.git
cd vim/src
make install

sudo apt -y install universal-ctags

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
