set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

script_dir=$(cd "$(dirname "$0")" && pwd)

${script_dir}/install-erlang.sh

sudo apt install -y cmake

if [ ! -d ~/repos/emqtt-bench ]; then
    mkdir -p ~/repos/emqtt-bench
    cd ~/repos/emqtt-bench
    git clone https://github.com/emqx/emqtt-bench .
fi

if [ ! -f ~/repos/emqtt-bench/emqtt_bench ]; then
    cd ~/repos/emqtt-bench
    make
fi


echo -------
echo SUCCESS
echo -------

