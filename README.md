### Libpruio Debian package ###

This package includes libpruio, with some patches applied as well as
addition of files needed for building a debian package.

Testing Debian packages (will be) available at: http://beagle.tuks.nl

Original source:

 https://www.freebasic-portal.de/dlfiles/592/libpruio-0.2.tar.bz2

Github repository:

 https://github.com/l4m4re/libpruio

The initial commit on the repository consists of the original source, so
the repository contains all patches and changes as applied to the
original source. 

Since there are no Makefiles in the original source, I wrote and used a
generic build and install system using gmake, which is available at:

 https://github.com/l4m4re/LaMake
 
--Arend, July 2016

### Original README.txt below ###

This package includes the source code of libpruio, a library supporting
digital and analog input and output capabilities for the Beaglebone
hardware with TI AM3359 CPU. Also examples and a tool for device tree
overlays are included.

(C) 2014 by Thomas{ dOt ]Freiherr[ aT ]gmx[ DoT }net

Library licence:

  LGPL2 (see http://www.gnu.org/licenses/lgpl-2.0.html)

Examples licence:

  GPL3 (see http://www.gnu.org/licenses/gpl-3.0.html)

Find a more detailed description at

  http://beagleboard.org/project/libpruio/
  http://www.freebasic.net/forum/viewtopic.php?f=14&t=22501

Find the on-line documentation at

  http://users.freebasic-portal.de/tjf/Projekte/libpruio/doc/html/index.html

Find the off-line documentation at

  http://www.freebasic-portal.de/downloads/fb-on-arm/anleitung-zu-libpruio-en-326.html

Find installation instructions at

  http://users.freebasic-portal.de/tjf/Projekte/libpruio/doc/html/_cha_preparation.html#SecInstallation
