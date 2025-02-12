# GDAL Docker Images

This is a Docker image containing the Geospatial Data Abstraction
Library (GDAL) compiled with a broad range of drivers.

## Update for Feb 2025

Since we made this repo, there is a better option for GDAL dockers from OSGEO, please see the OSGEO GDAL Docker images — <https://github.com/OSGeo/gdal/pkgs/container/gdal>.

You can peek & poke at the OSGEO GDAL Docker images if they see fit your needs.

``` bash
# linux
docker pull ghcr.io/osgeo/gdal:alpine-small-latest
docker pull ghcr.io/osgeo/gdal:alpine-normal-latest
docker pull ghcr.io/osgeo/gdal:ubuntu-small-latest
docker pull ghcr.io/osgeo/gdal:ubuntu-full-latest
```

```bash
# amd64
docker pull ghcr.io/osgeo/gdal:alpine-small-latest-amd64
docker pull ghcr.io/osgeo/gdal:alpine-normal-latest-amd64
docker pull ghcr.io/osgeo/gdal:ubuntu-small-latest-amd64
docker pull ghcr.io/osgeo/gdal:ubuntu-full-latest-amd64
```

#### Example Image sizes

```bash
docker images
```

#### Result

        REPOSITORY             TAG                          IMAGE ID       CREATED             SIZE
        ghcr.io/osgeo/gdal     ubuntu-full-latest-amd64     c25f936d3e89   3 weeks ago         2.26GB
        ghcr.io/osgeo/gdal     ubuntu-small-latest-amd64    b0054e7792ed   4 weeks ago         345MB
        ghcr.io/osgeo/gdal     alpine-normal-latest-amd64   0f7932d409b2   3 weeks ago         441MB
        ghcr.io/osgeo/gdal     alpine-small-latest-amd64    d81d558f4a52   3 weeks ago         86.8MB

---

### Test for Features

For example, you can test which OSGEO Docker images support PDF or your other favorite drivers

```
# Step 1, set your GDAL_DOCKER_IMAGE
# GDAL_DOCKER_IMAGE=ghcr.io/osgeo/gdal:ubuntu-normal-latest
# GDAL_DOCKER_IMAGE=ghcr.io/osgeo/gdal:alpine-small-latest-amd64
GDAL_DOCKER_IMAGE=ghcr.io/osgeo/gdal:alpine-small-latest-amd64

alias gdalinfoVersion='docker run -it --rm -v "$(pwd)":/data $GDAL_DOCKER_IMAGE gdalinfo --version'

# obtain a shell
docker run -it --rm -v "$(pwd)":/data $GDAL_DOCKER_IMAGE /bin/sh

# check Python version
docker run -it --rm -v "$(pwd)":/data $GDAL_DOCKER_IMAGE python --version

# run various GDAL commands
docker run -it --rm -v "$(pwd)":/data $GDAL_DOCKER_IMAGE gdalinfo --version
docker run -it --rm -v "$(pwd)":/data $GDAL_DOCKER_IMAGE gdalinfo --formats
docker run -it --rm -v "$(pwd)":/data $GDAL_DOCKER_IMAGE gdalinfo --formats | grep PDF
```

---


### Useful commands

```bash
# If you exit out of an AWS session, you can log back in to see if anything is still running
docker logs -f $GDAL_DOCKER_IMAGE
```


### Shell Aliases

You can use these bash shell aliases to simplify your use of gdal on the command prompt.

``` bash
alias gdal='docker run -it --rm -v $(pwd):/data $GDAL_DOCKER_IMAGE /bin/sh'
alias gdal_translate='docker run -it --rm -v $(pwd):/data $GDAL_DOCKER_IMAGE gdal_translate'
alias gdalinfo='docker run -it --rm -v $(pwd):/data $GDAL_DOCKER_IMAGE gdalinfo'
alias gdalwarp='docker run -it --rm -v $(pwd):/data $GDAL_DOCKER_IMAGE gdalwarp'
alias ogr2ogr='docker run -it --rm -v $(pwd):/data $GDAL_DOCKER_IMAGE ogr2ogr'
```
