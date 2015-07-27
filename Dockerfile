FROM ubuntu
MAINTAINER Vincent Gaudissart (gaudissart@gmail.com)

RUN \
  apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    software-properties-common \
    nodejs npm nodejs-legacy \
    git

RUN add-apt-repository ppa:mapnik/nightly-trunk

RUN \
  apt-get update && apt-get -y --no-install-recommends install \
    libmapnik mapnik-utils \
    mapnik-input-plugin-gdal mapnik-input-plugin-ogr \
    mapnik-input-plugin-postgis \
    mapnik-input-plugin-sqlite \
    mapnik-input-plugin-osm

RUN \
  npm update -g npm

WORKDIR /opt/app

RUN \
  git clone https://github.com/mapbox/mapbox-studio.git && \
    cd mapbox-studio && \
	npm install

WORKDIR /opt/app/mapbox-studio

VOLUME /opt/project

EXPOSE 3000

CMD ["node", "index.js", "--cwd", "/opt/project"]

