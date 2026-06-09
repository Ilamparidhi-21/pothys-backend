
# --- Base deps stage ---
FROM node:22.18.0-alpine AS deps
WORKDIR /app

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json ./
COPY libs ./libs
COPY apps/cms-service ./apps/cms-service

RUN pnpm install --frozen-lockfile

# --- Build stage ---
FROM deps AS build
WORKDIR /app

RUN pnpm --filter ./libs run build:all
RUN pnpm --filter ./apps/cms-service run build

# --- Production deps stage ---
FROM node:22.18.0-alpine AS prod-deps
WORKDIR /app

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json ./
COPY libs ./libs
COPY apps/cms-service/package.json ./apps/cms-service/package.json

RUN pnpm install --prod --frozen-lockfile

# --- Production stage ---
FROM node:22.18.0-alpine AS production
WORKDIR /app

ENV NODE_ENV=production

COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=prod-deps /app/package.json ./
COPY --from=prod-deps /app/apps ./apps

COPY --from=build /app/libs ./libs
COPY --from=build /app/apps/cms-service/dist ./dist

EXPOSE 3001

CMD ["node", "dist/main.js"]
