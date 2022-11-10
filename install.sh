echo "Welcome to the environment installer!"
# Check OS
if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X platform
    echo "Mac"
    cd ./macos
    ./main.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Linux platform
    echo "Linux"
    cd ./linux
    ./restore.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
    # Windows platform
    echo "Windows"
fi


