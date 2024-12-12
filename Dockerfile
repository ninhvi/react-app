# Stage 1: Development (Node.js Environment)
FROM node:20.18.1 AS development

WORKDIR /app
COPY ./package*.json /app/
RUN npm install
COPY . .

# Build project
RUN npm run build
RUN ls -al /app/build

# Stage 2: Nginx (Production Environment)
FROM nginx:stable-alpine

# Copy build folder from development stage
COPY --from=development /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80
