FROM node:16.8 as builder
WORKDIR /app
COPY ["package.json", "yarn.lock", "./"]
RUN yarn install
COPY . .
RUN yarn build

FROM nginx:1.19.2-alpine
COPY --from=builder ./app/build /usr/share/nginx/html
CMD nginx -g "daemon off;"