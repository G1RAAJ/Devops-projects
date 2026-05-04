# Use lightweight Node image
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Copy only package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy remaining source code
COPY . .

# Expose application port
EXPOSE 8079

# Start the app
CMD ["node", "server.js"]
