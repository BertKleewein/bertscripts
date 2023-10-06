set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

sudo apt update

${script_dir}/install-vim.sh
${script_dir}/install-tmux.sh
${script_dir}/install-python3.sh
${script_dir}/install-misc-utils.sh
${script_dir}/disable-sudo-password.sh

echo "success"

