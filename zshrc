# Enable completion:
autoload -Uz compinit && compinit
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

alias ll='ls -la'

source $HOME/.aws_shorthands

export PATH=~/bin:$PATH
export PATH=~/autotools/bin:$PATH
