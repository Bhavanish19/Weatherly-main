# deploy/docker/backend.Dockerfile
FROM node:20-alpine AS base

WORKDIR /app

# Install dependencies
COPY server/package*.json ./
RUN npm ci

# Copy source code
COPY server .

# Create .env from build args
ARG NODE_ENV
ARG PORT
ARG CORS_ORIGINS
ARG OPENWEATHER_API_KEY
ARG BASE_URL
ARG RATE_LIMIT_WINDOW_MS
ARG RATE_LIMIT_MAX
ARG CACHE_TTL

RUN echo "NODE_ENV=$NODE_ENV" > .env && \
    echo "PORT=$PORT" >> .env && \
    echo "CORS_ORIGINS=$CORS_ORIGINS" >> .env && \
    echo "OPENWEATHER_API_KEY=$OPENWEATHER_API_KEY" >> .env && \
    echo "BASE_URL=$BASE_URL" >> .env && \
    echo "RATE_LIMIT_WINDOW_MS=$RATE_LIMIT_WINDOW_MS" >> .env && \
    echo "RATE_LIMIT_MAX=$RATE_LIMIT_MAX" >> .env && \
    echo "CACHE_TTL=$CACHE_TTL" >> .env

# Build TypeScript code
RUN npm run build

# Remove development dependencies
RUN npm prune --production

EXPOSE 5000

CMD ["node", "dist/server.js"]