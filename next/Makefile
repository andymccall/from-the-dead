# ----------------------------
# Makefile Options
# ----------------------------

NAME			= ftd
SJASMPLUS       = sjasmplus
SJASMPLUS_FLAGS = --zxnext=cspect
RM              = rm -f
CSPECTEMU       = ${HOME}/development/tools/cspect/CSpect.exe
IMAGE           = ${HOME}/development/tools/sn-emulator/sn-emulator-22.10a.img
HDFMONKEY       = hdfmonkey

default: all

all:
	@echo "Building project..."
	mkdir -p bin
	mkdir -p lst
	mkdir -p sld
	${SJASMPLUS} ${SJASMPLUS_FLAGS} --fullpath --outprefix=bin/ --lst=lst/$(NAME).lst --sld=sld/$(NAME).sld src/main.asm

clean:
	@echo "Cleaning project..."
	rm -rf bin
	rm -rf lst
	rm -rf sld
	rm -rf *.bin
	if [ -f dev/$(NAME).nex ]; then rm dev/$(NAME).nex; fi

install:
	@echo "Copying nex file to image..."
	${HDFMONKEY} put ${IMAGE} bin/$(NAME).nex dev/$(NAME).nex

run:
	@echo "Launching emulator..."
	MONO_IOMAP=all mono ${CSPECTEMU} -tv -zxnext -s28 -w4 -mmc=${IMAGE}