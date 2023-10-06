set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

curl https://sh.rustup.rs -sSf | sh -s -- -y

