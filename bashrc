function __ruby_ps1 {
	 # Check if rmv_prompt exist.
	 [[ ! -r "$HOME/.rvm/bin/rvm-prompt" ]] && return

	 ruby_version=$("$HOME/.rvm/bin/rvm-prompt")
	 if [[ $ruby_version ]]; then
	     # This is because I want a space at the end if we are using an rvm
	     # Ruby version, but none if not. Bit weird, but it works!
	     echo "($ruby_version) "
	 fi
}

# Emacs packages. I still don't understand why it isn't installed in
# /usr/bin/...
export PATH="$HOME/.cask/bin:$PATH"

# Emacs theme need colors to work in console!
export TERM=xterm-256color

# Show git branch at the command prompt
export PS1="\$(__ruby_ps1)\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]\$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] "

export VISUAL='emacsclient -t'
export EDITOR='$VISUAL'
export ALTERNATE_EDITOR=""

alias ec='$VISUAL'
alias ek='emacsclient -e "(kill-emacs)"'

# RVM bash completion
[[ -r $HOME/.rvm/scripts/initialize ]] && . $HOME/.rvm/scripts/initialize
[[ -r $HOME/.rvm/scripts/completion ]] && . $HOME/.rvm/scripts/completion
