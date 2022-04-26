#!/usr/bin/env zsh

declare -A f=(
    [user_dirs]=~/.config/user-dirs.dirs
)

source "${f[user_dirs]}"

declare -a dir=(
    "${XDG_DOWNLOAD_DIR}"  # 1
)

inotifywait --quiet --monitor ~/Downloads --event create |
while read directory action file; do
    if [[ "$file" =~ .*torrent$ ]]; then # Does the file end with .xml?
        echo "torrent file" # If so, do your thing here!
    fi
done
