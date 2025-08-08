FROM node:22.1.0

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
COPY tsconfig*.json ./
RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi

# Copy the rest of the project (src, prisma, etc.)
COPY . .

# Generate Prisma client if schema exists
RUN if [ -f "./prisma/schema.prisma" ]; then npx prisma generate; else echo "Skipping prisma generate"; fi

# Build TypeScript
RUN npm run build

# Expose the port your app uses
EXPOSE 3000

# Start the app
CMD ["npm", "start"]