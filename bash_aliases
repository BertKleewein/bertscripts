###################################################################################################
# BASH
###################################################################################################

# Add to path
if [ -f "${HOME}/.pyenv/bin/pyenv" ]; then
    echo "Adding pyenv to path"
    export PATH="${HOME}/.pyenv/bin:${PATH}"
fi
if [ -e "${HOME}/.cargo/bin" ]; then
    echo "Adding cargo-built binaries to path"
    export PATH="${HOME}/.cargo/bin:${PATH}"
fi
if [ -d "${HOME}/bin" ]; then
    echo "Adding ~/bin binaries to path"
    export PATH="${HOME}/bin:${PATH}"
fi



# bashrc tricks: https://news.ycombinator.com/item?id=18898523
# add z: https://github.com/rupa/z
# mkdir ~/bin && curl https://raw.githubusercontent.com/rupa/z/master/z.sh -o ~/bin/z.sh && chmod +x ~/bin/z.sh
source ~/bin/z.sh

# .. to go up
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."


# This lets you easily search your command history by typing the beginning of a command and pressing the up arrow.
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

###################################################################################################
# GIT
###################################################################################################

ps -x | grep -v grep | grep ssh-agent > /dev/null
if [ $? -ne 0 ]; then
  echo "Agent not running.  Starting"
  eval $(ssh-agent -s)
fi

# Sometimes I forget the name of git branches I've worked on lately. This displays them with dates, most recent at the bottom:
git_branch_dates() {
    git for-each-ref --sort=authordate --format '%(authordate:iso) %(align:left,25)%(refname:short)%(end) %(subject)' refs/heads
}

# CD to the root of the current git project
alias root='git rev-parse --git-dir >/dev/null 2>&1 && cd `git rev-parse --show-toplevel` || echo "Not in git repo"'

alias g=git
alias ga='git add $(git rev-parse --show-toplevel)'
alias gap='ga && pre-commit'
alias gapt='gap && python -u -m pytest'
alias gaptx='gapt -x'
alias gs='git status'
alias gc='git checkout'
alias gcp='git checkpoint'
alias grh='git reset HEAD'
alias gd='git diff'
alias gdt='git difftool -y'
alias gm='git merge'
alias gf='git fetch'
alias gp='git push'
alias gfu='git fetch upstream'
alias gfo='git fetch origin'
alias gl='git log'
alias gb='git branch'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gdtm='git difftool -y $(git merge-base HEAD master)'


###################################################################################################
# DOCKER
###################################################################################################

alias d="docker"
alias dps="docker ps"
alias de="docker exec"
alias dl="docker logs"
alias dlf="docker logs -f"
alias dlft="docker logs --tail 200 -f"

clear-docker-logs() {
    sudo sh -c "truncate -s 0 /var/lib/docker/containers/*/*-json.log"
}

docker-restart() {
    clear-docker-logs && docker restart $1 && docker logs -f $1
}

docker-save-log() {
    dest=~/temp/$1.txt
    docker logs $1 &> $dest
    echo Log saved to $dest
}

docker-bash() {
    docker exec -it $1 /bin/bash
}

docker-sh() {
    docker exec -it $1 /bin/sh
}

alias dr=docker-restart
alias dsl=docker-save-log
alias dbash=docker-bash
alias dsh=docker-sh

###################################################################################################
# VIM
###################################################################################################

# this one lets me open an arbitrary file from the current project in Vim without having to glob:
vimf() {
    vim +find\ **/$1
}
    


###################################################################################################
# PYTHON
###################################################################################################

# changes your current working directory to be the library or site-packages location of that library
pycd () {
    pushd `python -c "import os.path, $1; print(os.path.dirname($1.__file__))"`;
}

alias p=python
alias pt=pytest
export PYTHONUNBUFFERED=1
export PYTHONASYNCIODEBUG=1

if (which pyenv > /dev/null); then
    export PATH="${HOME}/.pyenv/bin:${PATH}"
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"

    for ((major=3;major>=2;major--)); do
        for ((minor=19;minor>=1;minor--)); do
            for ((patch=19;patch>=1;patch--)); do
                if [ -f ~/env/Python-${major}.${minor}.${patch}/bin/activate ]; then
                    echo Using py${major}${minor} = ${major}.${minor}.${patch}
                    alias py${major}${minor}="source ~/env/Python-${major}.${minor}.${patch}/bin/activate"
                    break
                fi
            done
        done
    done
fi

###################################################################################################
# nmap
###################################################################################################
alias nmap-all='nmap -p1-65535'
alias nmap-os='sudo nmap -Pn -O'
alias nmap-open='nmap -Pn -sV'
alias nmap-scripts='nmap -Pn -sC'

###################################################################################################
# tmux
###################################################################################################
alias tls="tmux ls"
alias ta="tmux attach"
alias tat="tmux attach -t"
alias trs="tmux rename-session -t"
alias tns="tmux new -s"

###################################################################################################
# FINALLY
###################################################################################################

goproj() {
    name=$1
    if [ "$name" == "" ]; then
        echo usage: goproj [name]
    else
        cd ~/projects/${name} && \
            clear && \
           source ./activate
    fi
}

make_activate_file() {
name=$1
ROOT="${HOME}/projects/${name}"
F=${ROOT}/activate

cat <<EOF >${F}
    source ${ROOT}/env/bin/activate
    alias proj="cd ${ROOT}"
    if [ -d ${ROOT}/python ]; then 
        alias cdp="cd ${ROOT}/python"
    fi 
    if [ -d ${ROOT}/azure-iot-sdk-python ]; then 
        alias cdp="cd ${ROOT}/azure-iot-sdk-python"
    fi 
    if [ -d ${ROOT}/node ]; then 
        alias cdn="cd ${ROOT}/node"
    fi 
    if [ -d ${ROOT}/azure-iot-sdk-node ]; then 
        alias cdn="cd ${ROOT}/azure-iot-sdk-node"
    fi 
EOF
}


makeproj() {
    set -x
    name=$1
    if [ -f "$HOME/projects/${name}/activate" ]; then
        echo "Project ${name} already exists"
    else
        echo "Making ${name}" &&
        (mkdir -p "$HOME/projects/${name}" || true) &&
        cd "$HOME/projects/${name}"  &&
        python -m virtualenv env --prompt "${name}"  &&
        make_activate_file $name &&
        source ./activate &&
        echo "success"
    fi
    set +x
}


if [ -f "${HOME}/repos/dotfiles/setenv.sh" ]; then
    source "${HOME}/repos/dotfiles/setenv.sh"
fi

