# History settings
HISTFILE=~/.zsh_history     # Where history is stored
HISTSIZE=10000              # Number of commands stored in memory
SAVEHIST=10000              # Number of commands stored in history file
setopt appendhistory        # Append to history file rather than overwrite
setopt histignorealldups    # Don't save duplicates
setopt incappendhistory     # Save commands immediately, not when shell exits
setopt sharehistory         # Share history between sessions

# Enable completion system
autoload -Uz compinit
compinit
_comp_options+=(globdots) # With hidden files

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' %F{red}(%b)%f'

# Set up the prompt with git integration
setopt PROMPT_SUBST  # Allow variable substitution in prompt
PROMPT='%F{cyan}%n%f@%F{green}%m%f:%F{yellow}%~%f${vcs_info_msg_0_} %# '
# Enable color support
autoload -U colors && colors

# Key bindings
bindkey -e                  # Emacs-style key bindings (default)
bindkey '^[[A' up-line-or-search    # Up arrow for history search
bindkey '^[[B' down-line-or-search  # Down arrow for history search

# OS detection
if [[ "$(uname)" == "Darwin" ]]; then
    export CLICOLOR=1
    alias ls="ls -G"
    # macOS specific settings
    # Set PATH to include Homebrew packages
    if [ -d "/opt/homebrew/bin" ]; then
        export PATH="/opt/homebrew/bin:$PATH"    # M1/M2 Mac
    elif [ -d "/usr/local/bin" ]; then
        export PATH="/usr/local/bin:$PATH"       # Intel Mac
    fi
else
    # Linux specific settings
    alias ls="ls --color=auto"
    alias open="xdg-open"
fi

# Common aliases
alias ll="ls -lh"           # List long format with human-readable sizes
alias la="ls -lah"          # List all files including hidden
alias grep="grep --color=auto"
alias mkdir="mkdir -p"      # Create parent directories as needed
alias ..="cd .."
alias ...="cd ../.."

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gl="git log --pretty=oneline"
alias gp="git push"

# Editor setup
export EDITOR="vim"
export VISUAL="vim"

# Add personal bin to path
export PATH="$HOME/bin:$HOME/dotfiles/bin:$PATH"

# Load local settings if they exist
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# Optional: Add syntax highlighting if plugin exists
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Optional: Add autosuggestions if plugin exists
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
