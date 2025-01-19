FROM node:16-alpine AS build

WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./
RUN npm install

# Copy source files and build
COPY . .
RUN npm run build

# Production image
FROM nginx:alpine

# Copy built files and nginx config
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
