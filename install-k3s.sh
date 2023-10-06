set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

x=$(which k3s || true)
if [ "$x" == "" ]; then
    curl -sfL https://get.k3s.io | sh -
fi

if [ ! -f ~/.kube/config ]; then
    export KUBECONFIG=~/.kube/config
    mkdir ~/.kube 2> /dev/null
    sudo k3s kubectl config view --raw > "$KUBECONFIG"
    chmod 600 "$KUBECONFIG"
fi

${script_dir}/install-bashrc-helper.sh bashrc-k3s
