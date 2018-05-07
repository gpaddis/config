# If the destination file does not exist download from origin to destination
function checkOrDownload {
    local origin="$1" destination="$2"

    if [ ! -f $destination ]; then
        printf "${GREEN}Could not find $destination. Installation...${NC}\n"
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

    if [ ! -d $directory ]; then
        mkdir -p $directory
    fi
}

# Make a symlink to origin in destination if this does not exist
function makeSymLink {
    local origin="$1" destination="$2"

    if [ ! -f $destination ]
    then
        ln -s $origin $destination
        printf "${GREEN}Linked $origin to $destination.${NC}\n"
    else printf "${GREEN}The file $destination already exists.${NC}\n"
    fi
}
