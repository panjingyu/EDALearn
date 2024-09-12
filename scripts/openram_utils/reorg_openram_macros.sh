#!/usr/bin/zsh

OPENRAM_MACRO_DIR=./OpenRAM/macros
MACRO_DIR=./backend/macros

# under $OPENRAM_MACRO_DIR, there are directories for each macro
# if the directory is not a link, move it to $MACRO_DIR and create a link
# if the directory is a link, do nothing
for dir in $OPENRAM_MACRO_DIR/freepdk45_*; do
    if [[ -L $dir ]]; then
        echo "$dir is a link, skipping"
    elif [[ -d $dir ]]; then
        sudo chown -R $USER $dir
        mv $dir $MACRO_DIR
        ln -s ../../$MACRO_DIR/$(basename $dir) $dir
        echo "moved $dir to $MACRO_DIR and created a link"
    fi
done

# check $MACRO_DIR for any directories that exist in $OPENRAM_MACRO_DIR
# if there are any, link them in $OPENRAM_MACRO_DIR
for dir in $MACRO_DIR/freepdk45_*; do
    if [[ ! -L $OPENRAM_MACRO_DIR/$(basename $dir) ]]; then
        ln -s ../../$dir $OPENRAM_MACRO_DIR/$(basename $dir)
        echo "linked $dir in $OPENRAM_MACRO_DIR"
    elif [[ ! -d $OPENRAM_MACRO_DIR/$(basename $dir) ]]; then
        # check if the link goes to a valid place
        echo "$dir is a link, but the link is broken"
        echo "removing the link and creating a new one"
        unlink $OPENRAM_MACRO_DIR/$(basename $dir)
        ln -s ../../$dir $OPENRAM_MACRO_DIR/$(basename $dir)
    else
        echo "$dir is already linked in $OPENRAM_MACRO_DIR"
    fi
done