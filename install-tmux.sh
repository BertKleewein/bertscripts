set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

sudo apt install -y \
    tmux

cp ${script_dir}/tmux.conf ~/.tmux.conf

${script_dir}/install-bashrc-helper.sh bashrc-tmux

