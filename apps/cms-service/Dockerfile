
# --- Base stage ---
FROM node:22-alpine AS base
WORKDIR /app
RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json ./

COPY libs ./libs
COPY apps/cms-service ./apps/cms-service

RUN pnpm install
RUN pnpm --filter ./libs run build:all

# --- Build stage ---
FROM base AS build
WORKDIR /app/apps/cms-service
RUN pnpm run build

# --- Production stage ---
FROM node:22.18.0-alpine AS production
WORKDIR /app
RUN npm install -g pnpm

COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/package.json ./
COPY --from=base /app/pnpm-lock.yaml ./

COPY --from=build /app/libs ./libs
COPY --from=build /app/apps/cms-service/dist ./dist

EXPOSE 3001
CMD ["node", "dist/main.js"]
