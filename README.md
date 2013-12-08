opentrv-3d
==========

3D models of boxes for the [OpenTRV](http://opentrv.org.uk/) project.
The models are created in OpenSCAD and come with a `Makefile`. You can
build any of the models either in OpenSCAD using its graphical user
interface or via the command line by using the `make` command.

Building in OpenSCAD
====================

The model files are designed so that they can be built directly inside
OpenSCAD. In order to do this, start OpenSCAD and follow the procedure
below:
- Open the `.scad` file you want to use (`File -> Open` or `CTRL+O`);
- Render it (`Design -> Compile and Render (CGAL)` or `F6`);
- Export as STL (`Design -> Export as STL...`).

Note that some models in the `playpen` area make use of includes that
are external to this repository. The simplest way to download and install
those includes is to use `make` in the top level directory:

    make includes

Building using the `make` command
=================================

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

It will then create an `stl` directory that will contain `main` and `playpen`
sub-directories, each containing one `.stl` file per box.

Note that on the first run, you should be connected to the internet as it will
download dependencies needed for some of the boxes.

You can generate the `main` and `playpen` files separately:

    make main
    make playpen

You can also generate a single box if you know which one you want:

    make stl/main/box-v0_2r1.stl

Cleaning up the build products
------------------------------

You can clean up build products in two ways:

    make clean
    make cleanall

`make clean` will only clean the build products that are locally generated.
`make cleanall` will also delete the downloaded dependencies and will require
you to be connected to the internet next time you run `make`. So if you are
on the road far from a network connection, make sure you only run `make clean`.

Customising the model
=====================

Some parameters of each model can be customised to create a file for display or
for printing, or to take into account imprecisions of some printers. The main
custom options are in the `user-settings.scad` file and are explained in the
file itself.

