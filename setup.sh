# install zsh and prezto
sudo apt -y install zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

sudo chsh -s /bin/zsh nas

mv ~/dotfiles/.* ~/
mv ~/dotfiles/* ~/
mv prompt_matt_setup ~/.zprezto/modules/prompt/functions/

curl -fLo ~/.zprezto/modules/git/alias.zsh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/git/git.plugin.

# install vim and all extras
git clone https://github.com/vim/vim.git
cd vim/src
make install

sudo apt -y install ctags

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer --gocode-completer

# install golang
curl https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz | sudo tar -C /usr/local -zx
