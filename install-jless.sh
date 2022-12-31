set -e
sudo apt update
sudo apt install -y cargo libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev
cargo install jless
echo "Copy this into bashrc"
echo 'export PATH="${HOME}/.cargo/bin:${PATH}"'
