#!/bin/bash
#
# A script to quickly setup a new SuperCollider project.
# Creates a git repo and links the Sketch/ folder to a cloud service.
#
# usage: scproject-new "name"
#
PROJECT_NAME="$@"
CLOUD_STORAGE="$HOME/Dropbox/Sketch"
CLOUD_SERVICE="Dropbox"
if [ -n "$PROJECT_NAME" ]; then
    if [ ! -d "$PROJECT_NAME" ]; then
        # create dirs
        echo "# ====================================================="
        mkdir -p "$PROJECT_NAME"/{Classes,HelpSource/Classes,Sketch}
        echo "# Created a new SuperCollider project: '"$PROJECT_NAME"'"
        # create a git repo and make an initial commit
        cd "$PROJECT_NAME"
        git init > /dev/null
        echo "Sketch/" > .gitignore
        echo "$PROJECT_NAME" > README.md
        git add .
        git commit -a -m 'initial commit' > /dev/null
        echo -e "#\\t- a Git repository has been created"
        # symlink Sketch/
        if [ -d "$CLOUD_STORAGE" ] && [ ! -h "$CLOUD_STORAGE"/"$PROJECT_NAME" ]
        then
            ln -s `pwd`/Sketch "$CLOUD_STORAGE"/"$PROJECT_NAME"
            echo -e "#\\t- the Sketch/ directory was linked to $CLOUD_SERVICE"
        else
            echo "!! Symbolic link to $CLOUD_SERVICE failed!"
            echo "!! Delete the link manually, or change project name."
        fi
        echo "# ====================================================="
    else
        echo ERROR: Project \'"$PROJECT_NAME"\' already exists!
        echo No files has been overwritten or changed.
    fi
else
    echo ERROR: New projects must have a name!
fi
