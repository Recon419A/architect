# architect
Architect is a map generator for tabletop RPGs developed at Northwestern University by Drew Bronson (Recon419A). It is still being developed and is not yet stable, although you are welcome to contribute to its development or use it for your own projects.

## First-Time Setup
Architect has several prerequisites that must be met to start developing with it, including `gigls` and `rosette`.

### Installing gigls
*These instructions are adapted from a set of instructions written by Samuel Rebelsky for his own reference. At the time of writing, the original instructions were located at https://github.com/GlimmerLabs/virtual-mediascheme/blob/master/Building.md. They are reproduced here in a form which excludes several unnecessary steps related to setting up his preferred user interface for a virtual machine.*

To develop with Architect, you will need several packages used to control GIMP with Racket. First, install the appropriate packages with your package manager.

`sudo apt-get install libgimp2.0-dev racket git gedit vim feh`

Then clone and make the required repositories from GitHub.

```
git clone https://github.com/GlimmerLabs/gimp-dbus
git clone https://github.com/GlimmerLabs/louDBus
git clone https://github.com/GlimmerLabs/gigls
git clone https://github.com/GlimmerLabs/virtual-mediascheme 
```

First, make gimp-dbus.

```
cd gimp-dbus
make
cd ..
```

Then, make louDBus.

```
cd louDBus
make
raco link `pwd`
cd ..
```

Then, start GIMP and select `MediaScript -> DBus Server` from the menu bar.

Last, make `gigls`.

```
cd gigls
make
raco link `pwd`
```

### Installing Rosette
Rosette should be available through `raco` as a managed package. You will need Racket to use `raco`, but if you followed the steps above in "Installing gigls" you should already have Racket.

`raco pkg install rosette`

### Installing Architect
To install Architect, just clone it and execute it using Racket.

`git clone https://github.com/Recon419A/architect.git`

## Running Architect
In order to run Architect, GIMP needs to be running with the DBus server enabled. To start it, open GIMP and select `MediaScript -> DBus Server` to start the DBus Server used by `gigls`. You will then need to leave GIMP open as you develop.
