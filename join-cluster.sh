set -exuo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

CLUSTER_IP=$1
NODE_TOKEN="$2"

curl -sfL https://get.k3s.io | K3S_URL=https://${CLUSTER_IP}:6443 K3S_TOKEN="${NODE_TOKEN}" sh -

