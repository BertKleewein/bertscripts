set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

sudo cat /var/lib/rancher/k3s/server/node-token
