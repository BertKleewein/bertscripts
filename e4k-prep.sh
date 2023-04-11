
set -exuo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

# docker
x=$(which docker || true)
if [ "$x" == "" ]; then
    sudo apt install -y docker.io
    sudo usermod -aG docker $USER
fi

# k3s
x=$(which k3s || true)
if [ "$x" == "" ]; then
    curl -sfL https://get.k3s.io | sh -
fi

#helm
x=$(which helm || true)
if [ "$x" == "" ]; then
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
fi

# k9s
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

if [ ! -f ~/.kube/config ]; then
    export KUBECONFIG=~/.kube/config
    mkdir ~/.kube 2> /dev/null
    sudo k3s kubectl config view --raw > "$KUBECONFIG"
    chmod 600 "$KUBECONFIG"
fi

set +x
echo -------
echo SUCCESS
echo -------
