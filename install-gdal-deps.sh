#!/bin/env sh

##
# Install GDAL source dependencies
#

# mapbox, mb-util, json
# https://github.com/mapbox/mapbox-cli-py#installation
# https://github.com/mapbox/mbutil#installation
# https://www.npmjs.com/package/json
cd /tmp && \
  pip install --user mapboxcli && \
  easy_install mbutil && \
  npm -g install json

# Get source packages
cd /tmp/ && \
    wget -q http://s3.amazonaws.com/etc-data.koordinates.com/gdal-travisci/install-libecwj2-ubuntu12.04-64bit.tar.gz && \
    wget -q http://s3.amazonaws.com/etc-data.koordinates.com/gdal-travisci/install-libkml-r864-64bit.tar.gz && \
    wget -q http://s3.amazonaws.com/etc-data.koordinates.com/gdal-travisci/install-openjpeg-2.0.0-ubuntu12.04-64bit.tar.gz || exit 1

# Install libecwj2
tar xzf install-libecwj2-ubuntu12.04-64bit.tar.gz && \
    cp -r install-libecwj2/include/* /usr/local/include && \
    cp -r install-libecwj2/lib/* /usr/local/lib || exit 1

# Install libkml
tar xzf install-libkml-r864-64bit.tar.gz && \
    cp -r install-libkml/include/* /usr/local/include && \
    cp -r install-libkml/lib/* /usr/local/lib || exit 1

# Install openjpeg
tar xzf install-openjpeg-2.0.0-ubuntu12.04-64bit.tar.gz && \
    cp -r install-openjpeg/include/* /usr/local/include && \
    cp -r install-openjpeg/lib/* /usr/local/lib || exit 1


# Install PDFium
wget --no-verbose http://even.rouault.free.fr/install-pdfium-static-64bit.tar.bz2
tar xjf install-pdfium-static-64bit.tar.bz2
sudo cp -r install-pdfium-static/include/pdfium /usr/local/include
sudo cp -r install-pdfium-static/lib/pdfium /usr/local/lib

ldconfig
