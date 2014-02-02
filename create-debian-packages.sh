#!/bin/bash

# Update locales
./update-locales.sh

# Create a source distribution (tarball, zip file, etc.)
python setup.py sdist

# Creates Debian source package from Python package
cd dist
py2dsc -m 'freepto <deb@freepto.mx>' tortp-0.2.tar.gz

# Configure build
cd deb_dist/tortp-0.2
echo 'tortp.egg-info/*' > debian/clean
sed -i 's/source package automatically created by stdeb 0.6.0+git/Initial release. Closes: 1.0/' debian/changelog

# Building
debuild

# Coping deb package in main directory
cd ../../../
cp dist/deb_dist/python-tortp_*.deb .

# Build tortp and tortp-gtk
equivs-build tortp-deb
equivs-build tortp-gtk-deb
