FROM node:alpine as builder
WORKDIR /home/node
COPY ./package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx:latest
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /home/node/build /usr/share/nginx/html