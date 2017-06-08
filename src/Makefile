SHELL :=/usr/bin/env bash

EXEC:all

all: compile install

compile:
	valac --pkg gtk+-3.0 Hello.vala -o hello

install:
	mkdir -p /app/bin
	mv hello /app/bin/
	echo 'echo WHIZZZZZ!' > hee
	chmod +x hee
	mv hee /app/bin/
