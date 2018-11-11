FROM node:8.12.0

EXPOSE 3000

RUN mkdir /app
WORKDIR /app

ADD ./package.json /app
ADD ./package-lock.json /app

RUN npm i

ADD . /app

RUN npm run build

CMD npm start
