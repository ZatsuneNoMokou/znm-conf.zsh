#!/bin/zsh

__dirname=$(cd "$(dirname "$0")" || exit 1; pwd);
source "$HOME/.znm-conf.zsh/utils.zsh"
function () {
	cd "$__dirname" || exit 1

	mkdir -p ~/bin
	wget -q -O ~/bin/antigen.zsh.new git.io/antigen
	if [ $? -eq 0 ] && [ -e ~/.gitignore ]; then
		mv ~/bin/antigen.zsh.new ~/bin/antigen.zsh
	fi

	if [ ! -e ~/.gitignore ]; then
		touch ~/.gitignore
		git config --global core.excludesFile ~/.gitignore
	fi

	if [ ! -e ~/.bash_aliases ]; then touch ~/.bash_aliases;fi

	if ! __znm_cmd_exists thefuck; then
		if ! __znm_cmd_exists apt; then
			echo "thefuck is not installed \"pip3 install thefuck\""
		else
			echo "thefuck is not installed \"sudo apt install thefuck\""
		fi
	fi

	if __znm_cmd_exists apt; then
		if ! __znm_cmd_exists apt-show-versions; then
			echo "apt-show-versions is not installed \"sudo apt install apt-show-versions\""
		fi
	fi

	ln -sf "${__dirname}/zatsunenomokou_custom_theme.zsh-theme" ~/.oh-my-zsh/custom/themes/zatsunenomokou_custom_theme.zsh-theme
	ln -sf "${__dirname}/zatsunenomokou_custom_theme.zsh-theme" ~/.oh-my-zsh/custom/themes/zatsunenomokou_custom_theme_2.zsh-theme



	local tryLn=0
	if [ ! -e "$HOME/.zshrc" ]; then
		# if ~/.zshrc does not exist
		tryLn=1
	else
		if [[ -L "$HOME/.zshrc" ]]; then
			# If ~/.zshrc is a symbolic link
			local znmZsh=$(readlink -f -e -- "${__dirname}/zshrc")
			local result=$(readlink -f -e -- ~/.zshrc)
			if [[ "${result}" != "${znmZsh}" ]]; then
				tryLn=1
			fi
		else
			# if ~/.zshrc exist, and is not a symbolic link
			echo "~/.zshrc already exist and is not a link, please remove it manually (and make a backup if needed)"
		fi
	fi

	if [[ $tryLn == 1 ]]; then
		ln -s "${__dirname}/zshrc" ~/.zshrc
	fi



	unset __dirname
	cd - >/dev/null
}

