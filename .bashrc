# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Detect OS
case "$(uname -s)" in
    Linux*)     OS="Linux";;
    Darwin*)    OS="Mac";;
    CYGWIN*)    OS="Windows";;
    MINGW*)     OS="Windows";;
    *)          OS="Unknown";;
esac

# History settings
HISTCONTROL=ignoreboth  # ignoredups (duplicates) + ignorespace (cmd starting with space)
HISTSIZE=10000
HISTFILESIZE=10000

shopt -s histappend  # don't overwrite
shopt -s checkwinsize  # after each cmd

# Common aliases
alias ls="ls --color=auto"
alias ll="ls -lh"  # list, human-readable file size
alias la="ls -lah"  # include hidden
alias grep="grep --color=auto"
alias ..="cd .."  # quick go up
alias ...="cd ../.."  # quick go upup

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gl="git log --pretty=oneline"
alias gp="git push"

# OS specific settings
if [ "$OS" = "Mac" ]; then
    export CLICOLOR=1
    alias ls="ls -G"
elif [ "$OS" = "Linux" ]; then
    alias open="xdg-open"
    # Adds the 'open' command to Linux, mimicking macOS behavior.
fi

# Add ~/bin and ~/dotfiles/bin to PATH
export PATH="$HOME/bin:$HOME/.dotfiles/bin:$PATH"

# Simple prompt with git branch info
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Sets a colorful prompt showing username, hostname, current directory, and git branch
if [ "$OS" = "Mac" ]; then
    export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\[\033[31m\]\$(parse_git_branch)\[\033[m\] \$ "
else
    export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\[\033[31m\]\$(parse_git_branch)\[\033[m\] \$ "
fi
# \u = username, \h = hostname, \w = current directory, \$ = $ for regular users, # for root
# The \[\033[XXm\] parts set text colors

# Load local settings if they exist
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
