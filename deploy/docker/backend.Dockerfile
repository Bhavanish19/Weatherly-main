# deploy/docker/backend.Dockerfile
# Build stage
FROM node:18-alpine AS builder

# Add platform-specific build configurations and npm config
RUN apk add --no-cache python3 make g++ && \
    npm config set registry https://registry.npmjs.org/ && \
    npm config set strict-ssl false

WORKDIR /app

# Copy package files
COPY server/package*.json ./

# Install ALL dependencies
RUN --mount=type=cache,target=/root/.npm \
    npm config set fetch-retry-maxtimeout 600000 && \
    npm config set fetch-retry-mintimeout 10000 && \
    npm config set fetch-retries 5 && \
    npm install

# Copy TypeScript config and source files
COPY server/tsconfig.json ./
COPY server/src ./src

# Build time arguments with defaults
ARG NODE_ENV=production
ARG PORT=5002
ARG CORS_ORIGINS="*"
ARG OPENWEATHER_API_KEY
ARG BASE_URL="http://localhost"
ARG RATE_LIMIT_WINDOW_MS=900000
ARG RATE_LIMIT_MAX=100
ARG CACHE_TTL=1800000

# Set environment variables for build
ENV NODE_ENV=${NODE_ENV}
ENV PORT=${PORT}
ENV CORS_ORIGINS=${CORS_ORIGINS}
ENV OPENWEATHER_API_KEY=${OPENWEATHER_API_KEY}
ENV BASE_URL=${BASE_URL}
ENV RATE_LIMIT_WINDOW_MS=${RATE_LIMIT_WINDOW_MS}
ENV RATE_LIMIT_MAX=${RATE_LIMIT_MAX}
ENV CACHE_TTL=${CACHE_TTL}

# Build the TypeScript code
RUN npm run build

# Production stage
FROM node:18-alpine
WORKDIR /app

# Copy built assets and package files
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./

# Install production dependencies only
RUN npm config set registry https://registry.npmjs.org/ && \
    npm config set strict-ssl false && \
    npm config set fetch-retry-maxtimeout 600000 && \
    npm config set fetch-retry-mintimeout 10000 && \
    npm config set fetch-retries 5 && \
    npm ci --omit=dev

# Expose port
EXPOSE ${PORT}

# Set runtime environment variables
ENV NODE_ENV=${NODE_ENV}
ENV PORT=${PORT}
ENV CORS_ORIGINS=${CORS_ORIGINS}
ENV OPENWEATHER_API_KEY=${OPENWEATHER_API_KEY}
ENV BASE_URL=${BASE_URL}
ENV RATE_LIMIT_WINDOW_MS=${RATE_LIMIT_WINDOW_MS}
ENV RATE_LIMIT_MAX=${RATE_LIMIT_MAX}
ENV CACHE_TTL=${CACHE_TTL}

# Start the application
CMD ["node", "dist/server.js"]