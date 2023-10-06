set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

# docker
x=$(which docker || true)
if [ "$x" == "" ]; then
    sudo apt install -y docker.io
    sudo usermod -aG docker $USER
fi

${script_dir}/install-bashrc-helper.sh bashrc-docker
