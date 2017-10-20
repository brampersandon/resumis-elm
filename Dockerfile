FROM node:latest

ARG apiRoot

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN yarn
RUN "RESUMIS_API_ROOT=$apiRoot yarn build"

RUN mkdir -p /var/www/resumis-elm
RUN cp -R build/ /var/www/resumis-elm

VOLUME /var/www

CMD ["echo", "elm app build complete"]
