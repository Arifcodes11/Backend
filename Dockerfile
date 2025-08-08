# FROM node:22.1.0

# WORKDIR /app

# # Copy only needed files
# COPY package*.json ./
# COPY tsconfig*.json ./
# COPY src ./src

# # Copy Prisma folder only if it exists by copying everything, relying on .dockerignore
# COPY . .

# RUN npm install

# RUN if [ -f "./prisma/schema.prisma" ]; then npx prisma generate; else echo "Skipping prisma generate"; fi

# RUN npm run build

# EXPOSE 3000

# CMD ["npm", "start"]
# Use official Node.js LTS image
FROM node:22.1.0

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
COPY tsconfig*.json ./
RUN npm install

# Copy entire project (includes src, prisma, etc.)
COPY . .

# Generate Prisma client if schema exists
RUN if [ -f "./prisma/schema.prisma" ]; then npx prisma generate; else echo "Skipping prisma generate"; fi

# Build TypeScript
RUN npm run build

# Expose port used by the app (4000 as per your .env)
EXPOSE 4000

# Run the app
CMD ["npm", "start"]