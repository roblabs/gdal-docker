##
# homme/gdal
#
# This creates an Ubuntu derived base image that installs the latest GDAL
# subversion checkout compiled with a broad range of drivers.  The build
# process closely follows that defined in
# <https://github.com/OSGeo/gdal/blob/trunk/.travis.yml> but omits Java
# support.
#

# Ubuntu 14.04 Trusty Tahr
# https://docs.docker.com/engine/reference/builder/#from
FROM ubuntu:trusty

# Inspired by
#MAINTAINER Homme Zwaagstra <hrz@geodata.soton.ac.uk>
#   MAINTAINER Klokantech <https://www.klokantech.com>
# https://docs.docker.com/engine/reference/builder/#label
#  To view an image’s labels, use the `docker inspect` command.
LABEL maintainer="roblabs <http://RobLabs.com>"
LABEL description="minimal gdal with pdf"
LABEL usage="docker run -it --rm -v $(pwd):/data roblabs/gdal /bin/bash"

# Ensure the package repository is up to date
# https://docs.docker.com/engine/reference/builder/#run
RUN apt-get update -y

# Temporarily hack around a docker build issue. See
# <https://github.com/docker/docker/issues/6345#issuecomment-49245365>.
RUN ln -s -f /bin/true /usr/bin/chfn

# Install basic dependencies
RUN apt-get install -y \
    software-properties-common \
    python-software-properties \
    build-essential \
    wget \
    subversion

# Install gdal dependencies provided by Ubuntu repositories
RUN apt-get install -y \
    python-numpy \
    libpq-dev \
    libpng12-dev \
    libjpeg-dev \
    libgif-dev \
    libgeos-dev \
    libcurl4-gnutls-dev \
    libproj-dev \
    libxml2-dev \
    libexpat-dev \
    libxerces-c-dev \
    libnetcdf-dev \
    netcdf-bin \
    libpoppler-dev \
    gpsbabel \
    swig \
    libhdf4-alt-dev \
    libhdf5-serial-dev \
    poppler-utils \
    libfreexl-dev \
    unixodbc-dev \
    libepsilon-dev \
    liblcms2-2 \
    libpcre3-dev \
    python-dev \
    sudo

# Install the GDAL source dependencies
# https://docs.docker.com/engine/reference/builder/#add
ADD ./install-gdal-deps.sh /tmp/
RUN sh /tmp/install-gdal-deps.sh

# Install GDAL itself
ADD ./gdal-checkout.txt /tmp/gdal-checkout.txt
ADD ./install-gdal.sh /tmp/
RUN sh /tmp/install-gdal.sh

# Externally accessible data is by default put in /data
# https://docs.docker.com/engine/reference/builder/#volume
# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /data
VOLUME ["/data"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD gdalinfo --version
