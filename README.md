opentrv-3d
==========

3D models of boxes for the [OpenTRV](http://opentrv.org.uk/) project.
The models are create in OpenSCAD and come with a `Makefile` that can
generate STL files for use with a 3D printer.

Prerequisites
-------------

In order to build the STL files, you will need the following installed:
- Git,
- Python (to build the dependencies),
- OpenSCAD.

The `Makefile` is designed to run on Linux and has been tested on Ubuntu but
could be adapted to run on other platforms: if you want to adapt it so that it
runs cross-platform, I will gladly accept patches.

Buiding the STL files
---------------------

This is the easy part, just run:

    make

It will then create an `stl` directory that will contain one `.package`
directory per box; each of those will contain a number of STL files for each
component of the box.

Note that on the first run, you shold be connected to the internet as it will
download dependencies needed for some of the boxes.

Cleaning up the build products
------------------------------

You can clean up build products in two ways:

    make clean
    make cleanall

`make clean` will only clean the build products that are locally generated.
`make cleanall` will also delete the downloaded dependencies and will require
you to be connected to the internet next time you run `make`. So if you are
on the road far from a network connection, make sure you only run `make clean`.

