# GDAL Docker Images

This is an Ubuntu derived image containing the Geospatial Data Abstraction
Library (GDAL) compiled with a broad range of drivers.

## Docker hub

* https://hub.docker.com/r/roblabs/gdal/


## Usage

The following command will open a bash shell in an Ubuntu based environment
with GDAL available:

    docker run -it --rm roblabs/gdal /bin/bash

You will most likely want to work with data on the host system from within the
docker container, in which case run the container with the -v option. This
mounts a host directory inside the container; the following invocation maps the
host's local directory to /data in the container:

    docker run -it --rm -v $(pwd):/data roblabs/gdal /bin/bash

Note that the with the image tagged `latest`, GDAL represents the latest code
*at the time the image was built*. If you want to include the most up-to-date
commits then build the docker image yourself locally along these lines:

    docker build -t roblabs/gdal git://github.com/roblabs/gdal-docker/

or, if you have already cloned this repo

    docker build -t roblabs/gdal:latest .


### Useful commands

```bash
# If you exit out of an AWS session, you can log back in to see if anything is still running
docker logs -f roblabs/gdal
```


### Shell Aliases

You can use these bash shell aliases to simplify your use of gdal on the command prompt.

``` bash
alias gdal='docker run -it --rm -v $(pwd):/data roblabs/gdal /bin/bash'
alias gdal_translate='docker run -it --rm -v $(pwd):/data roblabs/gdal gdal_translate'
alias gdalinfo='docker run -it --rm -v $(pwd):/data roblabs/gdal gdalinfo'
alias gdalwarp='docker run -it --rm -v $(pwd):/data roblabs/gdal gdalwarp'
alias ogr2ogr='docker run -it --rm -v $(pwd):/data roblabs/gdal ogr2ogr'
```
