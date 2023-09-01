set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

sudo apt update
sudo apt install -y \
    vim \
    tmux \
    openssh-server \
    net-tools \
    curl \
    jq \
    python3 \
    python3-pip \
    python-is-python3

pip install --upgrade pip
pip install virtualenv


mkdir -p ~/bin
curl https://raw.githubusercontent.com/rupa/z/master/z.sh -o ~/bin/z.sh && chmod +x ~/bin/z.sh

mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undos

rm ~/.vimrc || true
rm ~/.gitconfig || true
rm ~/.tmux.conf || true

sudo -E sh -c "echo \"${USER}   ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers"
echo "User ${USER} added to sudoers.  Use 'sudo visudo' to verify."


cp ${script_dir}/vimrc ~/.vimrc
cp ${script_dir}/tmux.conf ~/.tmux.conf
cp ${script_dir}/bash_aliases ~/.bash_aliases

echo "success"

