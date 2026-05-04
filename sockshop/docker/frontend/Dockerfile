FROM node:16-alpine

WORKDIR /app

COPY ../../app/microservices-demo/src/front-end .

RUN npm install

EXPOSE 8079

CMD ["node", "server.js"]
