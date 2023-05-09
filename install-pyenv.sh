#-------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for
# license information.
#--------------------------------------------------------------------------

script_dir=$(cd "$(dirname "$0")" && pwd)

sudo apt-get install -y make build-essential zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev dos2unix libssl-dev
[ $? -eq 0 ] || { echo "APT failed"; exit 1; }

pyenv --version
if [ $? -ne 0 ]; then
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    [ $? -eq 0 ] || { echo "failed installing pyenv"; exit 1; }

    cd ${HOME}/.pyenv
    [ $? -eq 0 ] || { echo "failed cd ${HOME}/.pyenv"; exit 1; }

    # pyenv-installer gives us CRLF when we just want LF.  Force LF
    find -type f -a -not \( -path './versions/*' \) -print0 | \
        xargs -0 -I @@ bash -c 'file "$@" | grep ASCII &>/dev/null && dos2unix $@' -- @@
fi

export PATH="${HOME}/.pyenv/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

function build_failure_help {
    echo
    echo "If you're getting an error: ERROR: The Python ssl extension was not compiled. Missing the OpenSSL lib?"
    echo "You MAY need to switch out OpenSSL 1.1.x with OpenSSL 1.0."
    echo "BUT,  doing this will break NPM and other tools that depend on OpenSSL 1.1.x, so BE VERY CAREFUL"
    echo 
    echo "sudo apt install libssl1.0-dev"
    echo
    echo "Or, to learn more, read the following:"
    echo "https://github.com/pyenv/pyenv/wiki/common-build-problems"
    echo "https://github.com/pyenv/pyenv/issues/945"
    echo
    echo "The second link has a comment that suggests a private copy of OpenSSL 1.1.x headers to trick the compiler:"
    echo "https://github.com/pyenv/pyenv/issues/945#issuecomment-409627448"
    echo
}

