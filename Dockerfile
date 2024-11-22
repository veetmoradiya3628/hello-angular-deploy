FROM node:20-alpine3.19 AS build
WORKDIR /app
COPY ./package*.json .

RUN npm ci

COPY ./ ./
RUN npm run build

FROM nginx:1.27.2-alpine
EXPOSE 8080
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/hello-angular/browser /usr/share/nginx/html