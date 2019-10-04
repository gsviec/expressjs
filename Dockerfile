# vim:set ft=dockerfile:
FROM node:10.15.0-alpine
ENV PROJECT_DIR=/app
ENV PROJECT_NAME=exocreate
WORKDIR $PROJECT_DIR


RUN addgroup -S nodejs && adduser -S -g nodejs nodejs \
    && mkdir -p /home/nodejs/Downloads \
    && chown -R nodejs:nodejs /home/nodejs \
    && chown -R nodejs:nodejs $PROJECT_DIR
COPY package.json package-lock.json ./
RUN npm set progress=false && npm i
RUN npm install pm2 -g

COPY docker/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ADD . .
RUN rm -rf docker && rm -rf .git rm -rf /var/cache/apk/*
#COPY pm2/api-gateway.ecosystem.config.js ecosystem.config.js
COPY .env.prod .env
USER nodejs
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["start"]
EXPOSE 3000
VOLUME ["$PROJECT_DIR"]
