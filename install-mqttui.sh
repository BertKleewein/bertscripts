set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

x=$(which cargo || true)
if [ "$x" == "" ]; then
    ${script_dir}/install-rust.sh
    export PATH="${HOME}/.cargo/bin:${PATH}"
fi

if [ ! -f ~/.cargo/bin/mqttui ]; then
    if [ ! -d ~/repos/mqttui ]; then
        mkdir -p ~/repos/mqttui
        cd ~/repos/mqttui
        git clone https://github.com/EdJoPaTo/mqttui .
    fi

    cd ~/repos/mqttui
    cargo install --path .
fi


echo -------
echo SUCCESS
echo -------

