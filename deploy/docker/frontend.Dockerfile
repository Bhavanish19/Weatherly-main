FROM node:20-alpine AS base

# Install dependencies only when needed
FROM base AS deps
WORKDIR /app
COPY client/package.json client/package-lock.json ./
RUN npm ci

# Install additional tools for environment variable substitution
FROM base AS builder
# Install gettext package which provides envsubst
RUN apk add --no-cache gettext
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY client .

# Set build-time variables with defaults
ENV NEXT_PUBLIC_OPENWEATHER_API_KEY=${NEXT_PUBLIC_OPENWEATHER_API_KEY}
ENV NEXT_PUBLIC_BASE_URL=${NEXT_PUBLIC_BASE_URL}
ENV NEXT_PUBLIC_API_BASE_URL=${NEXT_PUBLIC_API_BASE_URL}
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=3000

# Create a template env file
RUN echo "NEXT_PUBLIC_OPENWEATHER_API_KEY=$NEXT_PUBLIC_OPENWEATHER_API_KEY" > .env.template && \
    echo "NEXT_PUBLIC_BASE_URL=$NEXT_PUBLIC_BASE_URL" >> .env.template && \
    echo "NEXT_PUBLIC_API_BASE_URL=$NEXT_PUBLIC_API_BASE_URL" >> .env.template  # Use the environment variable directly

# Create a script to generate environment files at runtime
RUN echo '#!/bin/sh' > /app/generate-env.sh && \
    echo 'export API_BASE_URL=${NEXT_PUBLIC_API_BASE_URL}' >> /app/generate-env.sh && \
    echo 'envsubst < .env.template > .env.production' >> /app/generate-env.sh && \
    echo 'cp -f .env.production .env.local' >> /app/generate-env.sh && \
    echo 'cp -f .env.production .env' >> /app/generate-env.sh && \
    chmod +x /app/generate-env.sh

# Run the script to generate initial env files for build
RUN /app/generate-env.sh
RUN npm run build

# Production image, copy all the files and run next
FROM base AS runner
RUN apk add --no-cache gettext

WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

# Create app directory with proper permissions
RUN mkdir -p /app && \
    addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs && \
    chown -R nextjs:nodejs /app

# Copy built files and environment generation script
COPY --from=builder --chown=nextjs:nodejs /app/src/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
COPY --from=builder --chown=nextjs:nodejs /app/.env.template ./.env.template
COPY --from=builder --chown=nextjs:nodejs /app/generate-env.sh ./generate-env.sh

# Ensure proper permissions
RUN chmod +x /app/generate-env.sh && \
    chown -R nextjs:nodejs /app

USER nextjs
EXPOSE 3000

# Generate environment files and start the server
CMD ["/bin/sh", "-c", "./generate-env.sh && node server.js"]