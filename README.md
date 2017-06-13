# architect
Architect is a map generator for tabletop RPGs developed at Northwestern University by Drew Bronson (Recon419A). It is still being developed and is not yet stable, although you are welcome to contribute to its development or use it for your own projects.

## First-Time Setup
Architect has several prerequisites that must be met to start developing with it, including `gigls` and `rosette`.

### Installing gigls
*These instructions are adapted from a set of instructions written by Samuel Rebelsky for his own reference. At the time of writing, the original instructions were located at https://github.com/GlimmerLabs/virtual-mediascheme/blob/master/Building.md. They are reproduced here in a form which excludes several unnecessary steps related to setting up his preferred user interface for a virtual machine and copying files related to his class.*

To develop with Architect, you will need several packages used to control GIMP with Racket. First, install `gimp` and `racket` with your package manager.

Then clone and make the required repositories from GitHub.

```
git clone https://github.com/GlimmerLabs/gimp-dbus
git clone https://github.com/GlimmerLabs/louDBus
git clone https://github.com/GlimmerLabs/gigls
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

Architect currently has fairly limited functionality, as it is still in development. The core functionality right now consists of the ability to learn colorization filters that correspond to English language words, given a supervised classification system.

### Teaching Architect a Color Filter
To teach Architect a filter, execute `source/interface.rkt`. In the resulting REPL, run the command `(learn-colorization word num-queries image)` where `word` is a string representing the term you wish to teach the computer, `num-queries` is how many sample points you're willing to rate for the computer, and `image` is an image (for quick testing, substitute `test-image` here).

Architect will then present you with an image (as a new image in GIMP), at which point you should enter a number between zero and one (such as `0.8`), indicating how much the colorization filter looks like what you want, and press enter. Architect will then show you another image, and the process will repeat `num-queries` times, after which Architect will show you a final image with the learned colorization and return you to the REPL. The colorization will be temporarily stored in the global variable `colorization-pairings`, but will be lost when you terminate or re-load the REPL. While it exists, you can apply a learned colorization to a new image with `(apply-colorization word image)`.

Currently, the algorithm underlying `learn-colorization` is a placeholder for the eventual machine-learning system, and simply uses weighted averaging of random samples.
