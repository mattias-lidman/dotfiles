# History
export HISTFILE=~/.zsh_history
export HISTFILESIZE=100000000
export HISTSIZE=100000
export SAVEHIST=50000 # > HISTSIZE to give HIST_EXPIRE_DUPS_FIRST some cuhsion
setopt HIST_EXPIRE_DUPS_FIRST
setopt INC_APPEND_HISTORY # Immediate append; don't lose history on unclean exit
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY # Format: `: <beginning time>:<elapsed seconds>;<command>'

# Enable completion:
autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# Completion colors
zstyle -e\
	':completion:*:default' list-colors\
	 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'


# Aliases
alias rm='rm -i' # Ask for confirmation

# OS specific stuff goes here:
case `uname` in
  Darwin)
    export LSCOLORS=ExGxcxdxCxegedabagacad
	alias ls='ls -G'
	alias ll='ls -laG'
  ;;
  Linux)
    # commands for Linux go here
  ;;
esac


source $HOME/.aws_shorthands

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    # Show `user@host` when away from home
    export PROMPT='%n@%M %F{245}%~%f %# '
else
    export PROMPT='%F{245}%~%f %# '
fi

# To get $PROMPT to play nice with virtualenv:
plugins=(virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)

export PATH=~/bin:$PATH

[ -f ~/.localzshrc ] && source ~/.localzshrc  # Anything specific to a particular host
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
