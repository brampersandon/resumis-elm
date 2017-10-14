FROM node:latest

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN yarn
RUN yarn build

RUN mkdir -p /var/www/resumis-elm
RUN cp -R build/ /var/www/resumis-elm

VOLUME /var/www

CMD ["echo", "elm app build complete"]
