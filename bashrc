# Emacs packages. I still don't understang why it isn't installed in
# /usr/bin/...
export PATH="$HOME/.cask/bin:$PATH"

# Emacs theme need colors to work in console!
export TERM=xterm-256color

# Show git branch at the command prompt
export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
