set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
