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

# Main target that uses a list of objects.

OBJECTS =stl/box-v0_09.stl
OBJECTS+=stl/box-v0_2r1.stl
OBJECTS+=stl/box-dd1.stl

all: includes $(OBJECTS)

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

# Includes and dependencies
includes: deps
	mkdir -p src/include
	cp deps/nuts-n-bolts/build/scad/iso261-extended.scad src/include
	cp deps/nuts-n-bolts/build/scad/screw.scad src/include

deps: deps/nuts-n-bolts

deps/nuts-n-bolts:
	git clone git@github.com:brunogirin/nuts-n-bolts.git deps/nuts-n-bolts
	deps/nuts-n-bolts/build.sh

