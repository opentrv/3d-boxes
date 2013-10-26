#  The OpenTRV project licenses this file to you
#  under the Apache Licence, Version 2.0 (the "Licence");
#  you may not use this file except in compliance
#  with the Licence. You may obtain a copy of the Licence at
#  
#  http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing,
#  software distributed under the Licence is distributed on an
#  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#  KIND, either express or implied. See the Licence for the
#  specific language governing permissions and limitations
#  under the Licence.
#  
#  Author(s) / Copyright (s): Bruno Girin 2013

# ---- Targets that control the list of packages and their content ----

# Main target that uses a package list.
# To create a new package, add it to the list below first,
# then add the dependencies for that package further down.

PACKAGES =stl/box-v0_09.package
PACKAGES+=stl/box-v0_2r1.package
PACKAGES+=stl/box-dd1.package
PACKAGES+=stl/trv.package

all: includes $(PACKAGES)

# Dependencies for each package, in practice a list of STL files
# followed by a dependency line.

V0_09_LAYERS =stl/box_layer-v0_09-0.stl
V0_09_LAYERS+=stl/box_layer-v0_09-1.stl
V0_09_LAYERS+=stl/box_layer-v0_09-2.stl
V0_09_LAYERS+=stl/box_layer-v0_09-3.stl
stl/box-v0_09.package: $(V0_09_LAYERS)

V0_2R1_LAYERS =stl/box_layer-v0_2r1-0.stl
V0_2R1_LAYERS+=stl/box_layer-v0_2r1-1.stl
V0_2R1_LAYERS+=stl/box_layer-v0_2r1-2.stl
V0_2R1_LAYERS+=stl/box_layer-v0_2r1-3.stl
stl/box-v0_2r1.package: $(V0_2R1_LAYERS)

DD1_LAYERS =stl/box_layer-dd1-0_1_2_merged.stl
DD1_LAYERS+=stl/box_layer-dd1-3.stl
stl/box-dd1.package: $(DD1_LAYERS)

TRV_LAYERS =stl/m30-connector.stl
TRV_LAYERS+=stl/trv-connector.stl
stl/trv.package: $(TRV_LAYERS)

stl/%.package:
	rm -rf $@
	mkdir -p $@
	cp $^ $@

# ---- Clean targets ----

clean:
	rm -rf src/include
	rm -rf stl
	rm -f src/box_layer-*.scad

cleanall: clean
	rm -rf deps

# ---- Internal targets ----

# STL file target

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard *.deps)

stl/%.stl: src/%.scad
	mkdir -p stl
	openscad -m make -o $@ -d $@.deps $<

# Auto-generation of box_layer-*.scad files
src/box_layer-%.scad:
	./generate-layer.sh $@

# Includes and dependencies
includes: deps
	mkdir -p src/include
	cp deps/nuts-n-bolts/build/scad/iso261-extended.scad src/include
	cp deps/nuts-n-bolts/build/scad/screw.scad src/include

deps: deps/nuts-n-bolts

deps/nuts-n-bolts:
	git clone git@github.com:brunogirin/nuts-n-bolts.git deps/nuts-n-bolts
	deps/nuts-n-bolts/build.sh

