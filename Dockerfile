# Use minimal Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy only the dependency definitions first (for Docker layer caching)
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production

# Copy rest of the app source code
COPY . .

# Expose port (optional, useful for local dev and docs)
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
