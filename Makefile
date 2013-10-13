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

PACKAGES=stl/box-v0_09.package stl/box-dd1.package stl/trv.package

V0_09_LAYERS=stl/box_layer-v0_09-0.stl stl/box_layer-v0_09-1.stl stl/box_layer-v0_09-2.stl stl/box_layer-v0_09-3.stl
DD1_LAYERS=stl/box_layer-dd1-0_1_2_merged.stl stl/box_layer-dd1-3.stl
TRV_LAYERS=stl/m30-connector.stl stl/trv-connector.stl

INCLUDE_TARGETS != grep -l '<include/' src/*.scad

all: $(PACKAGES)

deps: deps/nuts-n-bolts

deps/nuts-n-bolts:
	git clone git@github.com:brunogirin/nuts-n-bolts.git deps/nuts-n-bolts
	deps/nuts-n-bolts/build.sh

$(INCLUDE_TARGETS): includes

includes: deps
	mkdir -p src/include
	cp deps/nuts-n-bolts/build/scad/iso261-extended.scad src/include
	cp deps/nuts-n-bolts/build/scad/screw.scad src/include

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard *.deps)

stl/%.stl: src/%.scad
	mkdir -p stl
	openscad -m make -o $@ -d $@.deps $<

src/box_layer-%.scad:
	./generate-layer.sh $@

stl/box-v0_09.package: $(V0_09_LAYERS)
stl/box-dd1.package: $(DD1_LAYERS)
stl/trv.package: $(TRV_LAYERS)
stl/%.package:
	rm -rf $@
	mkdir -p $@
	cp $^ $@

clean:
	rm -rf src/include
	rm -rf stl
	rm -f src/box_layer-*.scad

cleanall: clean
	rm -rf deps

