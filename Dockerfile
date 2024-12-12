# Stage 1: Development (Node.js Environment)
FROM node:20.18.1 AS development

WORKDIR /app

COPY ./package*.json /app
RUN npm install 
COPY . .

# Build project
FROM development AS build
RUN npm run build

# Stage 2: Production (Nginx Environment)
FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/sites-available/default

# Expose cổng 80
EXPOSE 80
