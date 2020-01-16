# Fluid Corpus Manipulation: Max Objects Library

This repository hosts code for generating the Max objects and documentation resources for the Fluid Corpus Manipulation Project. Much of the actual code that does the exciting stuff lives in this repository's principal dependency,  the [Fluid Corpus Manipulation Library](). What lives here are: 

* A wrapper from our code to the Max API, that allows us to generate Max objects from a generic class. 
* Stubs for producing Max objects for each 'client' in the Fluid Corpus Manipulation Library. 
* CMake code for managing dependencies, building and packaging. 

The basis for this repo was the now-retired [Max dev-kit](). 

## I'm in a Hurry...

...and you already have a development environment set up, understand CMake, and have the Max SDK available? And Python 3 + DocUtils + Jinja if you want docs? 

Cool: 

```
cmake -DMAX_SDK_PATH=<location of your Max SDK> -DDOCS=<ON/OFF> ..
make 
```
You can either clone this repo directly into your Max packages folder (useful for development), or use CMake to generate a 'clean package' with `make install`. 

## Pre-requisites

* [CMake](http://cmake.org) >= 3.11
* A C++ 14 compliant compiler for Mac or Windows (via XCode tools on Mac, and Visual Studio 17 >= 15.9 on Windows)

You may wish to ensure that everything is working by building some Max SDK examples before continuing.

## Dependencies 

* [Max SDK](https://github.com/Cycling74/max-sdk): this is the only dependency we don't (optionally) manage for you, so there must be a version available to point to when you run, using the CMake Variable `MAX_SDK_PATH` (see below). It can live anywhere on your file system, although often it is convenient to install directly into your Max packages folder. 

These will be downloaded and configured automatically, unless you pass CMake a source code location on disk for each (see below): 
* [Fluid Corpus Manipulation Library]()
* [Eigen](https://gitlab.com/libeigen/eigen) (3.3.5)
* [HISSTools Library](https://github.com/AlexHarker/HISSTools_Library)

Unless you are simultaneously committing changes to these dependencies (or are *seriously* worried about disk space), there is nothing to be gained by pointing to external copies, and the easiest thing to is let CMake handle it all. 

## Building 

Simplest possible build: 
1. Download the Max SDK (>= 7.3.3) if you haven't already 
2. Clone this repo
```
git clone <whereis this>
```
3. Change to the directory for this repo, make a build directory, and run CMake, passing in the location for the Max SDK 
```
mkdir -p build && cd build 
cmake -DMAX_SDK_PATH=<location of your Max SDK> ..
```
At this point, CMake will set up your tool chain (i.e. look for compilers), and download all the dependencies. 

An alternative to setting up / running CMake directly on the command line is to install the CMake GUI, or use to use the curses gui `ccmake`.

With CMake you have a choice of which build system you use. 
* The default on Mac is `Unix Makefiles`, but you can use Xcode by passing `-GXcode` to CMake when you first run it. 
* The default on Windows is the latest version of Visual Studio installed. However, Visual Studio can open CMake files directly as projects, which has some upsides. When used this way, CMake variables have to be set via a JSON file that MSVC will use to configure CMake. 

When using `make`, then
```
make
```
will compile all objects ('targets', in CMake-ish). Alternatively, in Xcode or Visual Studio, running 'build' will (by default) build all objects. Note that these IDEs allow you to build both for debugging and for release, whereas with Makefiles, you need to re-run CMake and pass a `CMAKE_CONFIG` variable for different build types.

XCode projects should be generated to enable easy debugging, by associating the scheme for each object with `Max.app`, so that running will make a debug build and launch Max with the debugger attached. 

```
make install 
```
Will assemble  Max package in `release-packaging`. Note that this repository can be used directly as a Max package for development; the `install` step makes one for deployment (stripped of source code etc.). This is mostly for our convenience when deploying releases.

## Generating Documentation 

Pre-requisites: 
* Python 3 
* Docutils python package (ReST parsing)
* Jinja python package (template engine)

To generate `maxref.xml` documentation for the objects requires a further dependency, [flucoma_paramdump](), which we use to combine generated and human-written docs. We then pass `DOCS=ON` to CMake
```
cmake -DDOCS=ON ..
```
Unless we pass the location on disk of the `flucoma_paramdump`, CMake will again take care of downloading this dependency.

This process 
* has only ever been tested on Mac, so may well not work at all on Windows 
* can sometimes produce spurious warnings in Xcode, but *should* work (we use an anaconda environment here, and CMake gets the location of Python 3 via FindProgram; so long as there isn't anything too whacky in your `PATH`, all should be well)

## Structure: 

The top-level folders mostly correspond to those you would find in a typical Max package. Some more will appear when you compile (such as `externals` and possibly `docs`).

The main action is in `source`:
```
source
├── include
├── projects
└── script
``` 
* `include` contains the header files for the FluCoMa-Max wrapper 
* `projects` contains a subfolder for each object to be generated; each of these subfolders has a `.cpp` stub and a `CMakeLists.txt`. The `.cpp` file name needs to match its parent folder. 
* `scripts` contains cmake scripts (most significantly, `max-posttarget.cmake`, which sets behaviours for all the objects), linker flags, and a template for the objects `Info.plist` on Mac.

Note that all the signal processing objects use the word `tilde` rather than the character `~`, to avoid upsetting computers. This gets automatically converting during building, so your object will have the correct name. 

## Development: Manual Dependencies 

If you're making changes to the Fluid Corpus Manipulation Library and testing against Max (and, hopefully, our other deployment environments), then it makes sense to have the source for this cloned somewhere else on your disk, so that you can commit and push changes, and ensure that they work in all environments. This would be the case, e.g., if you're developing a new client. 

To bypass the automatic cloning of the Fluid Corpus Manipulation Library, we pass in the cache variable `FLUID_PATH`

```
cmake -DMAX_SDK_PATH=<location of your Max SDK> -DFLUID_PATH=<location of Fluid Corpus Manipulation Library> ..
```
Note 
1. You don't need to run CMake on the Fluid Corpus Manipulation Library first (well, you can, but it doesn't make any difference!). CMake's FetchContent facility will grab the targets from there, but won't look in its CMakeCache, so there should never be a conflict between the state of a build tree at `FLUID_PATH` and your build-tree here. 
2. It is **up to you** to make sure the commits you have checked out in each repository make sense together. We use tags against release versions on the `master` branch, so – at the very least – these should line up (unless you're tracking down some regression bug or similar). In general, there is no guarantee, or likelihood, that mismatched tags will build or run, as architectural changes can, do, will happen...

To include a manually checked out location of `flucoma_paramdump` (e.g. for debugging documentation generation), the same steps and caveats apply, but the variable is now `FLUID_PARAMDUMP_PATH`: 
```
cmake -DMAX_SDK_PATH=<location of your Max SDK> -DFLUID_PARAMDUMP_PATH=<location of flucoma_paramdump utilities> ..
```
### Dependencies of dependencies! 
The same steps and considerations apply to manually managing the dependencies of the Fluid Corpus Manipulation Library itself. If these aren't explicitly passed whilst running CMake against this build tree, then CMake will download them itself against the tags / commits we develop against. Nevertheless, if you are in the process of making changes to these libraries and running against this (which is much less likely than above), then the CMake variables of interest are: 
* `EIGEN_PATH` pointing to the location of Eigen on disk 
* `HISSTOOLS_PATH` pointing to the location of the HISSTools Library 

To find out which branches / tags / commits of these we use, look in the top level `CMakeLists.txt` of the  Fluid Corpus Manipulation Library for the `FetchContent_Declare` statements for each dependency. 

> This project has received funding from the European Research Council (ERC) under the European Union’s Horizon 2020 research and innovation programme (grant agreement No 725899).
