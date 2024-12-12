# Sử dụng image Node.js để xây dựng ứng dụng React
FROM node:16 AS build

# Chuyển đến thư mục làm việc của ứng dụng
WORKDIR /app

# Sao chép package.json và package-lock.json vào thư mục làm việc
COPY package*.json ./

# Cài đặt các phụ thuộc
RUN npm install

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Xây dựng ứng dụng React
RUN npm run build

# Chạy Nginx để phục vụ ứng dụng
FROM nginx:alpine

# Sao chép các file đã build vào thư mục của Nginx
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

# Mở cổng 80
EXPOSE 80

# Khởi động Nginx
CMD ["nginx", "-g", "daemon off;"]
