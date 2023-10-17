# gcodemillopt - Optimizes gcode from MakerCam for CNC mills and CNC laser engravers/burners
# See LICENSE file for copyright and license details.

include config.mk

all: options gcodemillopt

options:
	@echo build options:
	@echo "CXXFLAGS   = ${CXXFLAGS}"
	@echo "LDFLAGS    = ${LDFLAGS}"
	@echo "CXX        = ${CXX}"

clean:
	@echo cleaning
	@rm -f gcodemillopt/*.o gcodemillopt/gcodemillopt

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f gcodemillopt/gcodemillopt ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/gcodemillopt

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/gcodemillopt

%.cpp.o: gcodemillopt/%.cpp
	@echo ${CXX} -c ${CXXFLAGS} $< -o gcodemillopt/$@
	@${CXX} -c ${CXXFLAGS} $< -o gcodemillopt/$@

gcodemillopt: gcodemillopt.cpp.o
	@echo ${CXX} gcodemillopt/$< -o gcodemillopt/$@ ${LDFLAGS}
	@${CXX} gcodemillopt/$< -o gcodemillopt/$@ ${LDFLAGS}

.PHONY: all options clean install uninstall