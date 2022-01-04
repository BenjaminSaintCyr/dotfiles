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
source /etc/bashrc

# Adjust the prompt depending on whether we're in 'guix environment'.
YELLOW="\e[1;33m"
LILA="\e[1;35m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1="┌─ ${YELLOW}🖿 \w ${ENDCOLOR}| ${LILA}🤠 \u@\h${ENDCOLOR} | ${GREEN}🕒 \t${ENDCOLOR} | [ENV] \n└─> "
else
    PS1="┌─ ${YELLOW}🖿 \w ${ENDCOLOR}| ${LILA}🤠 \u@\h${ENDCOLOR} | ${GREEN}🕒 \t${ENDCOLOR} \n└─> "
fi
alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias mk='make -j 8'
alias emacs='emacsclient -c -a "" "$@"'
alias env='guix environment -m'
