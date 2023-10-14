set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

wget https://dl.smallstep.com/gh-release/cli/docs-cli-install/v0.24.4/step-cli_0.24.4_amd64.deb
sudo dpkg -i step-cli_0.24.4_amd64.deb
rm step-cli_0.24.4_amd64.deb
