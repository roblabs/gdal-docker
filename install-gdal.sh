#!/bin/env sh

##
# Obtain, configure and install GDAL
#

checkout=`cat /tmp/gdal-checkout.txt`

# Checkout GDAL from github
cd / && \
    svn checkout "https://svn.osgeo.org/gdal/${checkout}/" /tmp/gdal || exit 1

# Configure GDAL
cd /tmp/gdal/gdal && \
    ./configure --prefix=/usr/local \
    --without-libtool \
    --enable-debug \
    --with-webp \
    --with-jpeg12 \
    --with-python \
    --with-poppler \
    --with-pdfium=/usr/local || exit 1

# Make and install
make && \
    cd apps && \
    make test_ogrsf && \
    cd .. && \
    cd swig/perl && \
    make generate && \
    make && \
    cd ../.. && \
    rm -f /usr/lib/libgdal.so* && \
    make install && \
    ldconfig && \
    cd ../autotest/cpp && \
    make || exit 0

# Create the test directory
# mv /tmp/gdal/autotest /usr/local/share/gdal-autotest || exit 1
