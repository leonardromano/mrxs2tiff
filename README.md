mrxs2ometiff converter
=====================

Julia application to convert mrxs files to a OME-TIFF pyramids.
All credit goes to glencosoftware (https://github.com/glencoesoftware), who wrote the 
bioformats2raw and raw2ometiff applications that are at the heart of this application.

Requirements
============

Julia is required.
Java 8 or later is required.

libblosc (https://github.com/Blosc/c-blosc) version 1.9.0 or later must be installed separately.
The native libraries are not packaged with any relevant jars.  See also note in jzarr readme (https://github.com/bcdev/jzarr/blob/master/README.md)

 * Mac OSX: `brew install c-blosc`
 * Ubuntu 18.04+: `apt-get install libblosc1`
 
bioformats2raw (https://github.com/glencoesoftware/bioformats2raw) and raw2ometiff (https://github.com/glencoesoftware/raw2ometiff) need to be installed and working.

Installation
============

1. Clone the repository:

    git clone https://github.com/leonardromano/mrxs2tiff.git
    
2. (Optional) Download sample .mrxs files used for testing (while in project folder):

    git submodule update --init

Usage
=====

Modify the script file main.jl, specifying all the needed options (described there in detail) and run it using:

    julia main.jl

License
=======

The converter is distributed under the terms of the GPL license.
Please see `LICENSE.txt` for further details.
