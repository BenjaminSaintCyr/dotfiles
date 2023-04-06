# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

# Source the system-wide file.
# source /etc/bashrc

# Adjust the prompt depending on whether we're in 'guix environment'.
YELLOW="\e[1;33m"
LILA="\e[1;35m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1="┌─ ${YELLOW} \w ${ENDCOLOR}| ${LILA}\u@\h${ENDCOLOR} | ${GREEN}🕒 \t${ENDCOLOR} | [ENV] \n└─> "
else
    PS1="┌─ ${YELLOW} \w ${ENDCOLOR}| ${LILA}\u@\h${ENDCOLOR} | ${GREEN}🕒 \t${ENDCOLOR} \n└─> "
fi

CORES="$(grep -c ^processor /proc/cpuinfo)"

# cmd
alias ls="ls -p --color=auto"
alias ll="ls -lh"
alias grep="grep --color=auto"
alias mk="make -j ${CORES}"
# alias emacs="emacsclient -c -a \"\" $@"

alias env="guix environment -m"
alias bu="sudo aptitude -y update && sudo aptitude -y upgrade && sudo aptitude -y autoclean" # big update
alias qi="sudo aptitude -y install" # quick install
alias qu="sudo aptitude -y update" # quick update
export PATH=~/.local/bin/:$PATH
export PATH=~/dotfiles/bin/:$PATH

alias vg="vagrant"
alias vgu="vagrant up"
alias vgs="vagrant ssh"
alias vgh="vagrant halt -f"
alias vgd="vagrant halt destroy -f"

alias wordl="curl -s https://www.nytimes.com/svc/wordle/v2/$(date +"%Y-%m-%d").json | jq .solution"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

DOTNET_CLI_TELEMETRY_OPTOUT=1
