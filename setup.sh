git clone git@github.com:mattabullock/dotfiles.git

# install zsh and prezto
sudo apt-get install zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

chsh -s /bin/zsh

mv ~/dotfiles/* ~/
mv prompt_matt_setup ~/.zprezto/modules/prompt/functions/

git clone https://github.com/vim/vim.git
cd vim/src
make install

sudo apt-get install ctags

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
