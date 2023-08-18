if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" != "" ]; then
    echo Usage: $0 user.email user.name
fi

git config --global user.email "$1"
git config --global user.name "$2"
