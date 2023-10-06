set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

mkdir ~/temp/ || true
cd ~/temp/
sudo wget https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb
sudo apt install -y ./dive_0.9.2_linux_amd64.deb
