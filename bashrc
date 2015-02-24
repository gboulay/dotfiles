# Emacs packages. I still don't understang why it isn't installed in
# /usr/bin/...
export PATH="$HOME/.cask/bin:$PATH"

# Emacs theme need colors to work in console!
export TERM=xterm-256color

# Update rust nightly binaries
alias rust-upgrade="curl -s https://static.rust-lang.org/rustup.sh | sudo sh"
