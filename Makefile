SHELL :=/usr/bin/env bash

HOST_GTK_VERSION := $(shell pkg-config --modversion gtk+-3.0 | cut -d'.' -f1,2,3)

RUNTIME_VERSION := $(RUNTIME_VERSION)
ifndef RUNTIME_VERSION
	RUNTIME_VERSION=3.24
endif

EXEC:all

all: install-gnome-repo install-plateform-sdk remove-intermediate-repositories build-init build build-finish build-export install-remote install-lcallarec

install-gnome-repo:
	flatpak remote-add --if-not-exists gnome https://sdk.gnome.org/gnome.flatpakrepo

install-plateform-sdk:
	flatpak install gnome org.gnome.Sdk//$(RUNTIME_VERSION) org.gnome.Platform//$(RUNTIME_VERSION)

remove-intermediate-repositories:
	-rm -rf Hello hello-repo
	-flatpak remote-delete --user lcallarec --force
	-flatpak uninstall net.lcallarec.Hello/x86_64/master --user

build-init:
	flatpak build-init Hello net.lcallarec.Hello org.gnome.Sdk//$(RUNTIME_VERSION) org.gnome.Platform//$(RUNTIME_VERSION)

build:
	cd src && flatpak build ../Hello make
	cd ..

build-finish:
	flatpak build-finish Hello --socket=x11 wayland --share=network --command=hello


build-export:
	flatpak build-export hello-repo Hello

install-remote:
	flatpak --user remote-add --no-gpg-verify --if-not-exists lcallarec hello-repo

install-lcallarec:
	flatpak --user install lcallarec net.lcallarec.Hello

run:
	flatpak run net.lcallarec.Hello
	echo "... And the HOST Gtk+ version is " $(HOST_GTK_VERSION)
