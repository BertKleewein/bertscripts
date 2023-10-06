set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

sudo apt install -y \
    git \
    openssh-server \
    net-tools \
    curl \
    jq

${script_dir}/install-bashrc-helper.sh bashrc-add-paths
${script_dir}/install-bashrc-helper.sh bashrc-nmap
${script_dir}/install-bashrc-helper.sh bashrc-misc-utils
${script_dir}/install-bashrc-helper.sh bashrc-git

