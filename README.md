# Flatpak-playground

[![Build Status](https://travis-ci.org/lcallarec/flatpak-playground.svg?branch=master)](https://travis-ci.org/lcallarec/flatpak-playground)

As a reminder for me, but hopefully also a resource to introduce to __[Flatpak](http://flatpak.org/)__, here's a simple GTK3+ application that can be run with different runtimes & sdk.

```bash
git clone git@github.com:lcallarec/flatpak-playground.git
cd flatpak-playground

# Do all the process, then finally run the application
# Default runtime is org.gnome.Platform//3.24 & sdk is org.gnome.Sdk//3.24
make

# Where $RUNTIME_VERSION is 3.16, 3.18, 3.20, 3.22 or 3.24
make RUNTIME_VERSION=$RUNTIME_VERSION
```

Run the playground application :
```bash
make run
```
