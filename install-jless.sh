set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

x=$(which cargo || true)
if [ "$x" == "" ]; then
    ${script_dir}/install-rust.sh
    export PATH="${HOME}/.cargo/bin:${PATH}"
fi

sudo apt update
sudo apt install -y gcc libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev

cargo install jless

echo "Copy this into bashrc"
echo 'export PATH="${HOME}/.cargo/bin:${PATH}"'
