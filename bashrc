# Emacs packages. I still don't understang why it isn't installed in
# /usr/bin/...
export PATH="$HOME/.cask/bin:$PATH"

# Update rust nightly binaries
alias rust-update="curl -s https://static.rust-lang.org/rustup.sh | sudo sh"
