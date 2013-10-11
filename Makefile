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

STLFILES=stl/box_basic.stl stl/m30-connector.stl stl/trv-connector.stl

all: deps $(STLFILES)

deps: mkdirs deps/nuts-n-bolts

deps/nuts-n-bolts:
	git clone git@github.com:brunogirin/nuts-n-bolts.git deps/nuts-n-bolts
	deps/nuts-n-bolts/build.sh
	cp deps/nuts-n-bolts/build/scad/iso261-extended.scad src/incl
	cp deps/nuts-n-bolts/build/scad/screw.scad src/incl

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard *.deps)

stl/%.stl: src/%.scad
	openscad -m make -o $@ -d $@.deps $<

mkdirs:
	mkdir -p stl
	mkdir -p src/incl

clean:
	rm -rf stl
	rm -rf src/incl
	rm -rf deps

