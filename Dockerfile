# Sử dụng image Node.js để xây dựng ứng dụng React
FROM node:20 AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Chạy Nginx để phục vụ ứng dụng
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html


