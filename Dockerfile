FROM node:22-alpine as build

WORKDIR /app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:1.27-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *


COPY --from=build /app/dist/angular-app/browser .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]