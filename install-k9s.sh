set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

x=$(which k9s || true)
if [ "$x" == "" ]; then
    mkdir ~/temp || true
    cd ~/temp
    wget https://github.com/derailed/k9s/releases/download/v0.27.2/k9s_Linux_amd64.tar.gz
    sudo apt install -y tar
    tar -xvf k9s_Linux_amd64.tar.gz
    mkdir ~/bin || true
    mv k9s ~/bin
    export PATH="${HOME}/bin:${PATH}"
fi

