
set -exuo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

x=$(which cargo || true)
if [ "$x" == "" ]; then
    echo Rust is not installed.  Please run ./install_rust.sh or restart your shell.
    exit 1
fi

if [ ! -d ~/repos/mqttui ]; then
    mkdir -p ~/repos/mqttui
    cd ~/repos/mqttui
    git clone https://github.com/EdJoPaTo/mqttui .
fi

if [ ! -f ~/.cargo/bin/mqttui ]; then
    cd ~/repos/mqttui
    cargo install --path .
fi


set +x
echo -------
echo SUCCESS
echo -------

echo "Copy this into bashrc"
echo 'export PATH="${HOME}/.cargo/bin:${PATH}"'
