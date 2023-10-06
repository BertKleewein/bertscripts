set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)
BASHRC_FILENAME=$1

EXISTING_LINE=$(grep ${BASHRC_FILENAME} ~/.bashrc || true)
if [ "$EXISTING_LINE" == "" ]; then
    echo "source '${script_dir}/${BASHRC_FILENAME}'" >> ~/.bashrc
fi


