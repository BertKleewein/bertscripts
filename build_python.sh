set -e
export RUNTIME=$1

if [ "$RUNTIME" == "" ]; then
    echo "Usage: $0 [RUNTIME]"
    echo "Use 'pyenv install --list' to find all available"
    echo "e.g. '$0 3.10.10'"
    exit 1
fi

eval "$(pyenv init -)"
eval "$(pyenv init --path)"

sudo apt-get install -y build-essential checkinstall
sudo apt-get install -y libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
sudo apt-get install -y libffi-dev liblzma-dev libreadline-dev

echo calling pyenv install -s $RUNTIME
pyenv install -s $RUNTIME
[ $? -eq 0 ] || { echo "failed installing Python $RUNTIME"; build_failure_help; exit 1; }

pyenv shell $RUNTIME
[ $? -eq 0 ] || { echo "failed calling pyenv to use Python $RUNTIME for this script"; exit 1; }

python -m pip install --upgrade pip
[ $? -eq 0 ] || { echo "failed upgrading PIP for Python $RUNTIME"; exit 1; }

python -m pip install virtualenv
[ $? -eq 0 ] || { echo "failed installing virtualenv for Python $RUNTIME"; exit 1; }

python -m virtualenv "${HOME}/env/Python-${RUNTIME}"
[ $? -eq 0 ] || { echo "failed setting up a virtual environment for Python $RUNTIME"; exit 1; }

