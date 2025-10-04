# Step 1: Use official Node.js image as the base image
FROM node:18 AS build

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json (or yarn.lock) into the container
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the app into the container
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Serve the app using a simple web server
# Use a smaller, production-ready image to serve the app
FROM nginx:alpine

# Step 8: Copy the build output from the previous stage to Nginx’s public directory
COPY --from=build /app/build /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

RUN echo "Hello, How are you…" > hello1.html

copy . /usr/share/nginx/html

# Step 9: Expose port 80
EXPOSE 80

# Step 10: Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
