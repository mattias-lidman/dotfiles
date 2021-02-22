# History:
export HISTFILE=~/.zsh_history
export HISTFILESIZE=100000000 # Max number of lines
export HISTSIZE=100000
export SAVEHIST=50000 # < HISTSIZE to give HIST_EXPIRE_DUPS_FIRST some cushion
setopt HIST_EXPIRE_DUPS_FIRST # Trim oldest duplicates first
setopt INC_APPEND_HISTORY # Immediate append; don't lose history on unclean exit
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY # Format: `: <beginning time>:<elapsed seconds>;<command>'
setopt HIST_IGNORE_SPACE # Don't record commands with leading space

# Enable completion:
autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Case-insensitive completion:
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Completion colors:
zstyle -e\
	':completion:*:default' list-colors\
	 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

# Prompt setup:
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # Show `user@host` when away from home
    export PROMPT='%n@%M %F{245}%~%f %# '
else
    export PROMPT='%F{245}%~%f %# '
fi
# To get $PROMPT to play nice with virtualenv:
plugins=(virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)

# Aliases:
alias rm='rm -i' # Ask for confirmation
case `uname` in # OS specific aliases
  Darwin)
    export LSCOLORS=ExGxcxdxCxegedabagacad
    alias ls='ls -G'
    alias ll='ls -laG'
  ;;
  Linux)
    alias ll='ls -la --color'
  ;;
esac

# Misc. external commands:
source $HOME/.aws_shorthands
export PATH=~/bin:$PATH # Home directory binaries

[ -f ~/.localzshrc ] && source ~/.localzshrc # Anything specific to a particular host
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
