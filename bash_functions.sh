# Colors
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

# Return a 0 status if on a Mac OS.
isMacOS() {
    case `uname -s` in
        Darwin) return 0 ;;
        *) return 1 ;;
    esac
}

# Print a message in green
printGreen() {
    local message="$1"
    printf "${GREEN}[+] ${message}${NOCOLOR}\n"
}

# If the destination file does not exist download from origin to destination
checkOrDownload() {
    local origin="$1" destination="$2"
    if [ ! -f "$destination" ]; then
        printGreen "Could not find $destination. Installation..."
        # Use wget or curl
        if [ $(command -v wget) ]
        then wget "$origin" -O "$destination"
        else curl -o "$destination" "$origin"
        fi
    fi
}

# Check if a directory exists or create the full path
checkOrMakeDir() {
    local directory="$1"
    [ -d $directory ] || mkdir -p $directory
}

# Make a symlink to origin in destination if this does not exist
makeSymLink() {
    local origin="$1" destination="$2"
    if [ ! -f "$destination" ]
    then
        ln -sn "$origin" "$destination"
        printGreen "Linked $origin to $destination."
    else printGreen "The file $destination already exists."
    fi
}

# Return 1 if it can't find a command.
# https://stackoverflow.com/a/26759734/7874784
commandNotFound() {
    local _command="$1"
    [ ! -x "$(command -v $_command)" ]
}

# Return 1 if it can't find a file.
fileNotFound() {
    local _file="$1"
    [ ! -f $_file ]
}

# Return 1 if it can't find a directory.
dirNotFound() {
    local _file="$1"
    [ ! -d $directory ]
}

# Append a string to a file, skip if the string already exists.
appendStringToFile() {
    local string="$1"
    local filename="$2"
    if [[ ! $(grep "$string" "$filename") ]]; then
        echo "$string" >> "$filename"
    fi
}

# Fuzzy-search git branches
gch() {
 git checkout "$(git branch --all | fzf | tr -d '[:space:]')"
}
