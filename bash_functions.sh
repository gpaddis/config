# Colors
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

# Print a message in green
function printGreen {
    local message="$1"
    printf "${GREEN}[+] ${message}${NOCOLOR}\n"
}

# If the destination file does not exist download from origin to destination
function checkOrDownload {
    local origin="$1" destination="$2"

    if [ ! -f $destination ]; then
        printGreen "Could not find $destination. Installation..."
        # Use wget or curl
        if [ $(command -v wget) ]
        then wget $origin -O $destination
        else curl -o $destination $origin
        fi
    fi
}

# Check if a directory exists or create the full path
function checkOrMakeDir {
    local directory="$1"
    [ -d $directory ] || mkdir -p $directory
}

# Make a symlink to origin in destination if this does not exist
function makeSymLink {
    local origin="$1" destination="$2"

    if [ ! -f $destination ]
    then
        ln -s $origin $destination
        printGreen "Linked $origin to $destination."
    else printGreen "The file $destination already exists."
    fi
}

