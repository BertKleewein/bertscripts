set -euo pipefail
trap 'echo ERROR on line ${LINENO}' ERR

x=$(which helm || true)
if [ "$x" == "" ]; then
    TEMPFILE=$(mktemp)
    export DESIRED_VERSION=3.12.3
    wget https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 -O $TEMPFILE
    chmod +x $TEMPFILE
    $TEMPFILE --version 3.12.3
    rm $TEMPFILE
fi

