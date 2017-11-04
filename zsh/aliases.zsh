## system
# colored ls
alias ls="command ls -G"

alias lsa="ls -al"

# easy navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

#file size
alias fs="stat -f '%z bytes'"

# Recursively delete `.DS_Store` files
alias rmdss="find . -name '*.DS_Store' -type f -ls -delete"

# quick jump to projects folder
alias w="cd $WORKSPACE"

# reset DNS cache
alias flush="sudo killall -HUP mDNSResponder"

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Open all merge conflicts or currently changed files in Editor
alias fix="git diff --name-only | uniq | xargs code"

# create directory and cd into it
mkdirc() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# npm
alias no="npm outdated"
alias nog="npm outdated --depth=0 -g"