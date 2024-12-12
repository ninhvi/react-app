# Stage 1: Development (Node.js Environment)
FROM node:20.18.1 AS development

WORKDIR /app

RUN npm install 
COPY . .

# Build project
FROM development AS build
RUN npm build

# Stage 2: Production (Nginx Environment)
FROM nginx:stable-alpine

COPY --from=dist /app/dist /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf

# Expose cổng 80
EXPOSE 80
