FROM node:20-alpine

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn config set network-timeout 600000 -g \
 && yarn install --frozen-lockfile

COPY . .

RUN yarn build

EXPOSE 1337

ENV NODE_ENV=production

CMD ["yarn", "start"]

