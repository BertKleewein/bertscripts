set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

${script_dir}/install-k3s.sh
${script_dir}/install-helm.sh
${script_dir}/install-k9s.sh

echo -------
echo SUCCESS
echo -------
