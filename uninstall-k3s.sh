set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

/usr/local/bin/k3s-uninstall.sh
rm -r ~/.kube
