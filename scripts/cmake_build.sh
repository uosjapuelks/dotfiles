#! /bin/zsh

# Workspace path
WS_PATH=$HOME/dev/ros_ws 
# Package
PACKAGE="..."
# Path to src root 
SRC_ROOT=$WS_PATH/src/$PACKAGE

# if [ $# -eq 0 ]
cd $WS_PATH
catkin_make -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

cd $SRC_ROOT
ln -s $WS_PATH/build/compile_commands.json compile_commands.json
# fi

echo "\n========================================"
echo "Build Complete!"
echo "========================================"

