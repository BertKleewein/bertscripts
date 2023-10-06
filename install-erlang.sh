set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

x=$(which escript || true)
if [ "$x" == "" ]; then
    sudo apt install -y cmake
    sudo snap install erlang --classic
fi

