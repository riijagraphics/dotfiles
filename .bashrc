# ---------------------------------------------------------
#
# Bash and terminal configuration from Lars Graubner.
#
# Content:
# 1.  Prompt
# 2.  Completion
# 3.  Functions
# 4.  Aliases
# 5.  Misc
#
# ---------------------------------------------------------

# -----------------------------------------------------------------------------
# 1. PROMPT
# -----------------------------------------------------------------------------

red=$(tput setaf 1)
cyan=$(tput setaf 6)
magenta=$(tput setaf 5)
reset=$(tput sgr0)

# see https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
#GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_STATESEPARATOR=""
PROMPT_COMMAND='__git_ps1 "$cyan\w$reset" "\n➜ " " on $magenta%s$reset"'

# -----------------------------------------------------------------------------
# 2. COMPLETION
# -----------------------------------------------------------------------------

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

#--------------------------------------
# 3. FUNCTIONS
# -------------------------------------

# Work with homestead from any dir
function homestead() {
    ( cd ~/Homestead && vagrant $* )
}

# Create directory and cd into it
function mkd() {
    mkdir -p "$@" && cd "$_";
}

# Open all work related apps
# @TODO: add config in $HOME
function work() {
    open -a "Google Chrome" https://app.asana.com/0/568732081266236/board
    open -a "Spotify"

    open -a "PhpStorm" $HOME/code/breathe-api
    code $HOME/code/breathe-app
    open -a "Xcode" $HOME/code/breathe-app/ios

    cd "$HOME/codei/breathe-app"
}

# Open directory
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}

# Open in editor
function e() {
	if [ $# -eq 0 ]; then
		$EDITOR .;
	else
		$EDITOR "$@";
	fi;
}

# Create a todo file on desktop
function todo() {
  touch ~/Desktop/$*
}

# Update system and tools
function update() {
  if id -Gn ${whoami} | grep -q -w admin;
  then
    # update brew
    brew update;
    brew upgrade;
    brew cleanup;

    # update npm and modules
    npm update -g;
  else
    echo "This command can only be run as admin."
  fi
}

# move file/folder to trash
trash () {
  command mv "$@" ~/.Trash;
}

# extract most know archives with one command
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# -------------------------------------
# 4. ALIASES
# -------------------------------------

# Easy navigation
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# ls alias
alias lsa="ls -FGlAhp"

# Print file size
alias fs="stat -f '%z bytes'"

# Recursively delete `.DS_Store` files
alias rmdss="find . -name '*.DS_Store' -type f -ls -delete"

# Quick jump to folders
alias w="cd $WORKSPACE"
alias d="cd ~/Desktop"
alias dl="cd ~/Download"

# clear console
alias c="clear"

# Reset DNS cache
alias flushDNS="sudo killall -HUP mDNSResponder; sleep 2;"

# Pipe public key to clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Get public ip
alias pubip="curl -w '\n' https://api.ipify.org"

# Open all merge conflicts or currently changed files in Editor
alias fix="git diff --name-only | uniq | xargs $EDITOR"

# remove .DS_Store files
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

# Npm run dev alias
alias dev="npm run dev"

# Fun
alias idk="printf \"¯\_(ツ)_/¯\" | pbcopy && echo \"¯\_(ツ)_/¯ copied to clipboard\""

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Reload shell
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path="echo -e ${PATH//:/\\\n}"

# improved cat
alias cat="bat"

# improved top (more linux like)
alias top="htop"

# interactive disk usage tool
alias du="ncdu --color dark -rr --exclude .git --exclude node_modules"

# get current git branch
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# git
alias gs="git status -s"
alias ga="git add"
alias gac="git add -A && git commit -m"
alias gc="git commit --message"
alias gcb="git checkout -b"
alias gco="git checkout"
alias gcm="git checkout master"
alias gcd="git checkout develop"
alias gd="git diff"
alias gi="git init"
alias gcl="git clone"
alias gp="git push origin $(current_branch)"
alias gpf="git push origin $(current_branch) -f"
alias gpl="git pull origin $(current_branch) --rebase"
alias gl="git log -10 --reverse --pretty=oneline"
alias gundo="git reset --soft HEAD~"
alias gam="git commit --amend"
alias gf="git fetch"
alias grbc="git rebase --continue"
alias gsta="git stash"
alias gstp="git stash pop"

# simple changelog
alias did="vim +'normal Go' +'r!date' ~/did.txt"

# init new project
alias init="npx license mit > LICENSE && npx gitignore node && git init && npm init -y"

# -----------------------------------------------------------------------------
# 5. Misc
# -----------------------------------------------------------------------------

# nvm init
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# add ssh keys on login
ssh-add -A 2> /dev/null;

# ignore case on cd autocompletion
bind 'set completion-ignore-case on'

# init rbenv
eval "$(rbenv init -)"
