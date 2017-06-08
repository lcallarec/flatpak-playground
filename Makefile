SHELL :=/usr/bin/env bash

EXEC:all

with-gnome-3-20: install-plateform-sdk-3-20 all
with-gnome-3-22: install-plateform-sdk-3-22 all
with-gnome-3-24: install-plateform-sdk-3-24 all

install-plateform-sdk-3-20: install-gnome-repo
	flatpak install gnome org.gnome.Sdk//3.20 org.gnome.Platform//3.20

install-plateform-sdk-3-22: install-gnome-repo
	flatpak install gnome org.gnome.Sdk//3.22 org.gnome.Platform//3.22

install-plateform-sdk-3-24: install-gnome-repo
	flatpak install gnome org.gnome.Sdk//3.24 org.gnome.Platform//3.24

all: install-gnome-repo install-plateform-sdk remove-intermediate-repositories build-init make build-finish build-export install-remote install-lcallarec run

install-gnome-repo:
	flatpak remote-add --if-not-exists gnome https://sdk.gnome.org/gnome.flatpakrepo

install-plateform-sdk:
	flatpak install gnome org.gnome.Sdk//3.24 org.gnome.Platform//3.24

remove-intermediate-repositories:
	-rm -rf Hello hello-repo
	-flatpak remote-delete --user lcallarec --force
	-flatpak uninstall net.lcallarec.Hello/x86_64/master --user

build-init:
	flatpak build-init Hello net.lcallarec.Hello org.gnome.Sdk//3.24 org.gnome.Platform//3.24

make:
	cd src && flatpak build ../Hello make && cd -

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
