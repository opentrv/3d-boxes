#!/usr/bin/env bash

if [ $# -lt 1 ]; then
    echo "Usage $0 file_name"
    exit 1
fi

fname=$1
core0=${1%%.scad}
core1=${core0##*box_layer-}
box=${core1%%-*}
layer=${core1##*-}

cat > $fname << END
use <box-$box.scad>

layer_$layer();
END

