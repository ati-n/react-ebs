# ==== CONFIGURE =====
# Use a Node 16 base image
FROM node:19-alpine3.16 as builder
# Set the working directory to /app inside the container
WORKDIR /my-react-app
# Copy app files
COPY . .
# ==== BUILD =====
# Install dependencies (npm ci makes sure the exact versions in the lockfile gets installed)
RUN npm ci 
# Build the app
RUN npm run build

# ==== RUN =======

# Bundle static assets with nginx
FROM nginx:1.23.4-alpine as production
# Set the env to "production"
ENV NODE_ENV production
# Copy built assets from `builder` image
COPY --from=builder /my-react-app/dist /usr/share/nginx/html
# Add your nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Expose port
EXPOSE 80
# Start nginx
CMD ["nginx", "-g", "daemon off;"]