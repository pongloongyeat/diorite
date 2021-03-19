# Diorite

Diorite makes use of [GTK](https://www.gtk.org/) and [Granite](https://github.com/elementary/granite) to show native dialogs more easily for CLI applications on elementaryOS. <!-- Wording might need an update -->

## Building and Installation

You'll need the following dependencies:

- libgtk-3-dev
- libgranite-dev
- meson
- valac

Run `meson build` to configure the build environment. Change to the build directory and run `ninja` to build

```bash
meson build --prefix=/usr
cd build
ninja
```

To install, use ninja install, then execute with `com.github.pongloongyeat.diorite --help` to see available options.

```bash
sudo ninja install
com.github.pongloongyeat.diorite --help
```
