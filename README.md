# `vcpkg-registry`

*Oh dip* - [vcpkg now supports custom registries](https://devblogs.microsoft.com/cppblog/registries-bring-your-own-libraries-to-vcpkg/). 

No more messing with `--overlay-ports` for serenial.io (except for during testing).

## Setup `vcpkg` to use this registry
First ensure that the most up-to-date `vcpkg` is in use by pulling the latest release and calling the bootstrap script for your target.


## Just Using `--overlay-ports`
If you would rather not setup this repository as a registry then it is possible to clone this repo somewhere sensible and use the `--overlay-ports=<PATH_TO_THIS_REPO\ports>` option for `vcpkg install`

## Portfiles
### NI LabVIEW CINTools

This portfile copies the headers and libraries from a LabVIEW install to allow external libraries to interface to LabVIEW's memory manager, user events, debug and utility routines.

Currently only Windows and Linux targets are supported and it is assumed that the default directories are used namely
* 32-bit Windows: `C:\Program Files (x86)\National Instruments\LabVIEW <VERSION>\cintools`
* 64-bit Windows: `C:\Program Files\National Instruments\LabVIEW <VERSION>\cintools`
* 32-bit Linux (untested): `/usr/local/natinst/LabVIEW-<VERSION>/cintools`
* 64-bit Linux: `/usr/local/natinst/LabVIEW-<VERSION>-64/cintools`

*PRs to include Mac OSX/OS11 support are welcome!*

The <VERSION> can be specified by abusing `vcpkg`'s optional-library-feature system. Currently versions 2012 to 2020 (inclusive) are supported with 2020 being the default.

To install use any other version than 2020 specify the release year with `[]` square brackets such as:
```powershell
    PS C:\src\vcpkg> ./vcpkg.exe install ni-labview-cintools[2018]
```

## Development
When testing portfiles make use of the `--overlay-ports=<DIR_TO_PORT_FILE>` and `--binarysource=clear` flags to specify where the ports file is an to avoid using the cached version.