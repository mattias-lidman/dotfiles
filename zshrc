# Enable completion:
autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

alias ll='ls -la'

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
export PATH=~/autotools/bin:$PATH
