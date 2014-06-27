# Aliases
alias g='git'
compdef g=git
alias gst='git status -sb'
compdef _git gst=git-status
alias gl='git pull'
compdef _git gl=git-pull
alias gp='git push'
compdef _git gp=git-push
alias gc='git commit -v'
compdef _git gc=git-commit
alias ga='git add'
compdef _git ga=git-add

function gcm() {
  git commit -m "$*"
}

