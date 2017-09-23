# GDAL Docker Images

This is an Ubuntu derived image containing the Geospatial Data Abstraction
Library (GDAL) compiled with a broad range of drivers. The build process
closely follows that defined in the
[GDAL TravisCI tests](https://github.com/OSGeo/gdal/blob/trunk/.travis.yml) but
omits Java support.


## Usage

The following command will open a bash shell in an Ubuntu based environment
with GDAL available:

    docker run -t -i roblabs/gdal /bin/bash

Running the container without any arguments will by default run the GDAL test
suite:

    docker run roblabs/gdal:latest

You will most likely want to work with data on the host system from within the
docker container, in which case run the container with the -v option. This
mounts a host directory inside the container; the following invocation maps the
host's local directory to /data in the container:

    docker run -it --rm -v $(pwd):/data roblabs/gdal:latest /bin/bash

Note that the with the image tagged `latest`, GDAL represents the latest code
*at the time the image was built*. If you want to include the most up-to-date
commits then build the docker image yourself locally along these lines:

    docker build -t gdal:latest git://github.com/roblabs/gdal-docker/

or, if you have already cloned this repo

    `docker build -t roblabs/gdal:latest .`
