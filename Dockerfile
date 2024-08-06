tage 1: Build the React app
FROM node:14 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY my-react-app/package*.json ./

# Install dependencies
RUN npm install

# Copy the entire app source
COPY my-react-app/ .

# Build the React app for production
RUN npm run build

# Stage 2: Serve the React app using a lightweight web server
FROM nginx:alpine

# Copy the build output to Nginx's html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# # Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
