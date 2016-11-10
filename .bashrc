# User dependent .bashrc file
if [[ $bashprofile_loaded != true ]]; then
    echo sourcing bash profile
    . ~/.bash_profile
fi

export bashrc_loaded=true

# Terminal Banner - For fun
printf "\n"
printf "           ___       __   __         ___ \n"
printf "     |  | |__  |    /  \` /  \  |\/| |__  \n"
printf "     |/\| |___ |___ \__, \__/  |  | |___ \n"
printf "%s\n" " --------------------------------------------"
echo "     Vim Version: $(vim --version | awk 'NR == 1{ print $5 }')"
echo "     Git Version: $(git --version | awk '{ print $3 }')"
echo "     Date & Time: $(date | awk '{ print $3 " " $2 " " $6 ", " $4}')"

# Essentially "Portable" rootname resolution, normalized to a UNIX path
cd # Apparently this is needed
ROOTNAME_TPDEV=$(pwd -W)
ROOTNAME_TPDEV=$(cd "${ROOTNAME_TPDEV%PortableGit*}" && pwd)

if [[ ! $(echo $PATH | grep ruby) ]]; then
    PATH="$HOME/bin/ffmpeg/bin:$PATH"
    PATH="$HOME/bin/ruby/2.1.7/bin:$PATH"
    PATH="$HOME/.gem/ruby/bin:$PATH"
    PATH="$PATH:$HOME/bin/ruby/devkit/bin"
    PATH="$HOME/bin/ruby/devkit/mingw/bin:$PATH"
    PATH="/vanilla:$HOME/bin/node/:$PATH"
    PATH="$HOME/bin/cmake-3.4.0-win32-x86/bin:$PATH"
    PATH="$HOME/bin:$PATH"
    PATH="$PATH:./node_modules/.bin" # Allows downloaded mosules to be run from root.

    # MARKDOWN, PYTHON AND LATEX
    PATH="$ROOTNAME_TPDEV/Pandoc/:$ROOTNAME_TPDEV/MikTeX/miktex/bin:$ROOTNAME_TPDEV/MikTeX/SumatraPDF:$ROOTNAME_TPDEV/WinPython-32bit-3.4.3.5/python-3.4.3:$PATH"
fi

# Aliases
alias lprx="proxy_on proxy1.ap.webscanningservice.com:3128"
alias less="/usr/bin/less"
alias lprm="proxy_off"
alias cls='clear; history -c'
alias reload='source ~/.bashrc'

alias prj='cd "J:\The Files\The Software Files\Projects"'
alias sch='cd "J:\Documents\BSDE"'
alias msl='time "J:\The Files\The Software Files\Projects\Learn\LearnC++\MagicSquarer\runmagic.exe"'

alias gulp="gulp --color"

# Turn proxy on by default
lprx
cd

# Youtube - Get (ytg)
alias ytg="youtube-dl.exe -f 18 -i"
alias lynda-dl="youtube-dl.exe -f 2-360 -i -u ParkerPenn -p A7eL910H"
alias vims="vim -S ~/.vim/session.vim"

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hf --color'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

# Shell Options
shopt -s cdspell;

# Don't use ^D to exit
set -o ignoreeof

# Use case-insensitive filename globbing
shopt -s nocaseglob

for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '/n')" scp sftp ssh;

. ~/.bash_prompt
