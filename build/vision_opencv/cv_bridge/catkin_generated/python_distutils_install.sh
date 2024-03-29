#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ucar/cvbridge_py3/src/vision_opencv/cv_bridge"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ucar/cvbridge_py3/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ucar/cvbridge_py3/install/lib/python3/dist-packages:/home/ucar/cvbridge_py3/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ucar/cvbridge_py3/build" \
    "/usr/bin/python3" \
    "/home/ucar/cvbridge_py3/src/vision_opencv/cv_bridge/setup.py" \
    build --build-base "/home/ucar/cvbridge_py3/build/vision_opencv/cv_bridge" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/ucar/cvbridge_py3/install" --install-scripts="/home/ucar/cvbridge_py3/install/bin"
