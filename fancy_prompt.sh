### Taken from Barry Clark's bashstrap (https://github.com/barryclark/bashstrap.git)

### To use, add the following to your .bashrc or .bash_profile :
### source (the/path/to/)fancy_prompt.sh

### Prompt Colors
# Modified version of @gf3’s Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
#    tput sgr0 >>>> Not sure what this does, but if uncommented makes scp fail
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
	BLACK=$(tput setaf 190)
	MAGENTA=$(tput setaf 9)
	ORANGE=$(tput setaf 172)
	GREEN=$(tput setaf 184)
	PURPLE=$(tput setaf 141)
	WHITE=$(tput setaf 244)
    else
	BLACK=$(tput setaf 190)
	MAGENTA=$(tput setaf 5)
	ORANGE=$(tput setaf 4)
	GREEN=$(tput setaf 2)
	PURPLE=$(tput setaf 1)
	WHITE=$(tput setaf 7)
	fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    BLACK="\033[01;30m"
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

export BLACK
export MAGENTA
export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working tree clean"* ]] && echo "*"
    #echo ""
}
function parse_git_branch() {
    repo=$(basename `git rev-parse --show-toplevel 2> /dev/null` 2> /dev/null)
    branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/")
    [[ $repo ]] && echo "$repo/$branch"
}

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⚡  "

export PS1="\[${BOLD}${MAGENTA}\]\u\[$WHITE\] @ \[$ORANGE\]MacBook \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n$symbol\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"


### Misc

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

