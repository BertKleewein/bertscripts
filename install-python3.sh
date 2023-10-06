set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

sudo apt install -y \
    python3 \
    python3-pip \
    python-is-python3

pip install --upgrade pip
pip install virtualenv

${script_dir}/install-bashrc-helper.sh bashrc-python
${script_dir}/install-bashrc-helper.sh bashrc-projects
