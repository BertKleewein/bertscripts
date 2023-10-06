set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

if [ "$1" == "" ]; then
    echo Usage: $0 hostname
fi
hostnamectl hostname $1
echo use 'hostnamectl' command to verify change
echo SUCCESS
