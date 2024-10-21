FROM node:20 AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm install -g @angular/cli \
  && ng build --configuration production

#http sunucusu ile host
FROM nginx:alpine

COPY --from=build /app/dist/etiya9.crm/browser /usr/share/nginx/html
EXPOSE 80

# 10.25
