# Use lightweight Node.js Alpine image
FROM node:20-alpine

# Set working directory inside container
WORKDIR /app

# Copy only package files first (better caching)
COPY package*.json ./
COPY tsconfig*.json ./

# Install dependencies
RUN npm install

# Copy all source code (src, prisma, etc.)
COPY . .

# Generate Prisma client if schema exists
RUN if [ -f "./prisma/schema.prisma" ]; then npx prisma generate; else echo "Skipping prisma generate"; fi

# Build TypeScript
RUN npm run build

# Expose the port your app runs on (change if needed)
EXPOSE 4000

# Start the app
CMD ["npm", "start"]
