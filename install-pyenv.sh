#-------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for
# license information.
#--------------------------------------------------------------------------

script_dir=$(cd "$(dirname "$0")" && pwd)


pyenv --version
if [ $? -ne 0 ]; then
    sudo apt install -y dos2unix

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

echo "pyenv is installed"

