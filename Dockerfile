FROM node:latest AS build
WORKDIR /app
COPY package.json ./
RUN npm config rm proxy
RUN npm config rm proxy --global
RUN npm config rm https-proxy
RUN npm config rm https-proxy --global
RUN npm config rm registry

RUN npm config set registry http://registry.npmjs.org

RUN npm install -g @angular/cli
RUN npm install
COPY . .
RUN npm run build -prod


FROM nginx:1.17.1-alpine
COPY --from=build /app/dist /usr/share/nginx/html
