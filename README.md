# `vcpkg-registry`

*Oh dip* - [`vcpkg` now supports custom registries](https://devblogs.microsoft.com/cppblog/registries-bring-your-own-libraries-to-vcpkg/).

## Setup `vcpkg` to use Manifests and Registries
First ensure that the most up-to-date `vcpkg` is in use by pulling the latest release and calling the bootstrap script for your target.

Next we need to add the varaiables `manifests` and `registries` to the comma separated list in the environmental variable `VCPKG_FEATUTRE_FLAGS`.

For Windows Users this can be accomplished by using the *Environment Variables GUI* (System Properties>>Advanced (tab)>>Environment Variables (button)) and adding the value to the User Variables section. You will then need to logout and login to ensure this change is applied. Alternatively the powershell command `$env:VCPKG_FEATURE_FLAGS = "manifests,registries"` will set the non-persistent env. variable.

## Setup Your Project Manifest and `vcpkg-configuration`

Add `vcpkg-configuration.json` to the same directory as the CMakeLists.txt in your project which specifies where `vcpkg` can resolve different dependencies

```json
{
    "registries": [
      {
        "kind": "git",
        "repository": "https://gitlab.com/serenial/vcpkg-registry.git",
        "packages": [ "ni-labview-cintools" ]
      }
    ]
  }
```
The project manifest `vcpkg.json` can be used as though the packages are in `vcpkg`'s main registry:
```json
{
    "name": "my-lovely-project",
    "version": "0",
    "dependencies": [
        "zlib",
        "opencv3",
        {
            "name":"ni-labview-cintools",
            "features": ["2020"]
        },
    ]
}
```
## Just Using `--overlay-ports`
If you would rather not setup this repository as a registry then it is possible to clone this repo somewhere sensible and use the `--overlay-ports=<PATH_TO_THIS_REPO\ports>` option for `vcpkg install`

## Portfiles
The port files provided by this registry are:

### NI LabVIEW CINTools

This portfile copies the headers and libraries from a LabVIEW install to allow external libraries to interface to LabVIEW's memory manager, user events, debug and utility routines.

Currently only Windows and Linux targets are supported and it is assumed that the default directories are used namely
* 32-bit Windows: `C:\Program Files (x86)\National Instruments\LabVIEW <VERSION>\cintools`
* 64-bit Windows: `C:\Program Files\National Instruments\LabVIEW <VERSION>\cintools`
* 32-bit Linux (untested): `/usr/local/natinst/LabVIEW-<VERSION>/cintools`
* 64-bit Linux: `/usr/local/natinst/LabVIEW-<VERSION>-64/cintools`

*PRs to include Mac OSX/OS11 support are welcome!*

The <VERSION> can be specified by abusing `vcpkg`'s optional-library-features system. Currently versions 2012 to 2020 (inclusive) are supported with 2020 being the default.

## Development
When testing portfiles make use of the `--overlay-ports=<DIR_TO_PORT_FILE>` and `--binarysource=clear` flags to specify where the ports file is an to avoid using the cached version.