# Build stage
FROM node:18-alpine AS builder

# Add platform-specific build configurations and npm config
RUN apk add --no-cache python3 make g++ && \
    npm config set registry https://registry.npmjs.org/ && \
    npm config set strict-ssl false

WORKDIR /app

# Copy package files
COPY client/package*.json ./

# Install ALL dependencies
RUN --mount=type=cache,target=/root/.npm \
    npm config set fetch-retry-maxtimeout 600000 && \
    npm config set fetch-retry-mintimeout 10000 && \
    npm config set fetch-retries 5 && \
    npm install

# Copy configuration files with correct paths
COPY client/tsconfig.json ./
COPY client/next.config.mjs ./
COPY client/postcss.config.mjs ./
COPY client/tailwind.config.ts ./
COPY client/.eslintrc.json ./
COPY client/.prettierrc ./
COPY client/.prettierignore ./
COPY client/components.json ./

# Copy source directory
COPY client/src/ ./src/

# Create public directory and copy if exists
RUN mkdir -p public
COPY client/src/public/ ./public/

# Build time arguments with defaults
ARG NEXT_PUBLIC_OPENWEATHER_API_KEY="a74e368f22ed5a82ea99bf5433ddebfc"
ARG NEXT_PUBLIC_BASE_URL="http://localhost:3000"
ARG NEXT_PUBLIC_API_BASE_URL="http://localhost:5002"

# Set environment variables for build
ENV NEXT_PUBLIC_OPENWEATHER_API_KEY=$NEXT_PUBLIC_OPENWEATHER_API_KEY
ENV NEXT_PUBLIC_BASE_URL=$NEXT_PUBLIC_BASE_URL
ENV NEXT_PUBLIC_API_BASE_URL=$NEXT_PUBLIC_API_BASE_URL
ENV NEXT_TELEMETRY_DISABLED=1

# Build the application
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Copy necessary files from builder
COPY --from=builder /app/.next/ ./.next/
COPY --from=builder /app/public/ ./public/
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/next.config.mjs ./

# Install production dependencies only
RUN npm config set registry https://registry.npmjs.org/ && \
    npm config set strict-ssl false && \
    npm config set fetch-retry-maxtimeout 600000 && \
    npm config set fetch-retry-mintimeout 10000 && \
    npm config set fetch-retries 5 && \
    npm ci --omit=dev

# Expose port
EXPOSE 3000

# Set runtime environment variables
ENV NODE_ENV=production
ENV PORT=3000
ENV NEXT_TELEMETRY_DISABLED=1
ENV NEXT_PUBLIC_OPENWEATHER_API_KEY=$NEXT_PUBLIC_OPENWEATHER_API_KEY
ENV NEXT_PUBLIC_BASE_URL=$NEXT_PUBLIC_BASE_URL
ENV NEXT_PUBLIC_API_BASE_URL=$NEXT_PUBLIC_API_BASE_URL

# Start the application
CMD ["npm", "start"]