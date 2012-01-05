if [ -d ~/.oh-my-zsh ]
then
  echo "\033[0;33mYou already have Oh My Zsh installed.\033[0m You'll need to remove ~/.oh-my-zsh if you want to install"
  exit
fi

echo "\033[0;34mCloning Oh My Zsh...\033[0m"
/usr/bin/env git clone https://github.com/pludoni/oh-my-zsh.git ~/.oh-my-zsh

echo "\033[0;34mLooking for an existing zsh config...\033[0m"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]
then
  echo "\033[0;33mFound ~/.zshrc.\033[0m \033[0;32]Backing up to ~/.zshrc.pre-oh-my-zsh\033[0m";
  cp ~/.zshrc ~/.zshrc.pre-oh-my-zsh;
  rm ~/.zshrc;
fi

echo "\033[0;34mUsing the Oh My Zsh template file and adding it to ~/.zshrc\033[0m"
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

echo "\033[0;34mCopying your current PATH and adding it to the end of ~/.zshrc for you.\033[0m"
echo "export PATH=$PATH" >> ~/.zshrc

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`

echo "\033[0;32m"'       ___                __                         '"\033[0m"
echo "\033[0;32m"'      /\_ \              /\ \                  __    '"\033[0m"
echo "\033[0;32m"' _____\//\ \    __  __   \_\ \    ___     ___ /\_\   '"\033[0m"
echo "\033[0;32m"'/\  __`\\ \ \  /\ \/\ \  / __ \  / __`\ /  _ `\/\ \  '"\033[0m"
echo "\033[0;32m"'\ \ \_\ \\_\ \_\ \ \_\ \/\ \_\ \/\ \_\ \/\ \/\ \ \ \ '"\033[0m"
echo "\033[0;32m"' \ \ ,__//\____\\ \____/\ \___,_\ \____/\ \_\ \_\ \_\'"\033[0m"
echo "\033[0;32m"'  \ \ \/ \/____/ \/___/  \/__,_ /\/___/  \/_/\/_/\/_/'"\033[0m"
echo "\033[0;32m"'   \ \_\                                             '"\033[0m"
echo "\033[0;32m"'    \/_/                                             '"\033[0m"

echo "\n\n \033[0;32m ..version of oh-my-zsh is now installed.\033[0m"
/usr/bin/env zsh
source ~/.zshrc
