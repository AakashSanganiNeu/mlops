# Use Node.js image to build the React app
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Build the app
RUN npm run build

# Use Nginx to serve the build
FROM nginx:stable-alpine

# Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy built React app to Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]