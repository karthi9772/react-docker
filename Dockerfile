# Step 1: Use an official Node.js image as the base image
FROM node:18 AS build

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json to install dependencies
COPY package.json package-lock.json ./

# Step 4: Install project dependencies
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Build the app using Vite
RUN npm run build

# Step 7: Use a lightweight web server (nginx) to serve the app
FROM nginx:alpine

# Step 8: Copy the build directory from the previous stage
COPY --from=build /app/dist /usr/share/nginx/html

# Step 9: Expose the port on which the app will be served
EXPOSE 80

# Step 10: Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
