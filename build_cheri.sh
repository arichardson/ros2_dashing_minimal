#!/bin/bash
#
# build command for colcon

TOOLCHAIN_PATH="$HOME/cheri/ros2_dashing_min/CrossToolchain.cmake"

# necessary to find the .cmake files for poco pre-built library
CMAKE_POCO_PATH="$HOME/cheri/output/sdk/sysroot128/usr/local/mips-purecap/libcheri/cmake"

if [ "$#" -eq 0 ]; then
	colcon build \
		--packages-skip-build-finished \
		--cmake-args \
			-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_PATH \
			-DBUILD_TESTING=NO \
			-DTHIRDPARTY=ON \
			-DCMAKE_PREFIX_PATH="$CMAKE_POCO_PATH;$CMAKE_PREFIX_PATH" \
		--no-warn-unused-cli

elif [ "$#" -eq 1 ]; then
    if [ "$1" = "clean" ]; then
		rm -r ./build ./install
		colcon build \
			--cmake-args \
				-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_PATH \
				-DBUILD_TESTING=NO \
				-DTHIRDPARTY=ON \
				-DCMAKE_PREFIX_PATH="$CMAKE_POCO_PATH;$CMAKE_PREFIX_PATH" \
			--no-warn-unused-cli
    else
		rm -r ./build/$1 ./install/$1
		colcon build \
			--packages-skip-build-finished \
			--packages-up-to=$1 \
			--cmake-args \
				-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_PATH \
				-DBUILD_TESTING=NO \
				-DTHIRDPARTY=ON \
				-DCMAKE_PREFIX_PATH="$CMAKE_POCO_PATH;$CMAKE_PREFIX_PATH" \
			--no-warn-unused-cli
    fi
elif [ "$#" -eq 2 ]; then
    if [ "$2" = "clean" ]; then
		rm -r ./build/$1 ./install/$1
		colcon build \
			--packages-up-to=$1 \
			--cmake-args \
				-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_PATH \
				-DBUILD_TESTING=NO \
				-DTHIRDPARTY=ON \
				-DCMAKE_PREFIX_PATH="$CMAKE_POCO_PATH;$CMAKE_PREFIX_PATH" \
			--no-warn-unused-cli
	else
	    echo "Usage: ./build.sh [package] [clean]"
    fi
else
    echo "Usage: ./build.sh [package] [clean]"
fi
