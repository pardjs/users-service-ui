FROM node:10 as builder
RUN pwd
WORKDIR /
RUN npm i yarn -g
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn
COPY . .
RUN yarn run generate

FROM nginx:latest  
COPY --from=builder /dist/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf