# Create app directory
FROM node:14 AS base
WORKDIR usr/src/app

# Install dependencies
FROM base AS dependencies
COPY package*.json .
RUN npm ci

# Build artifacts
FROM dependencies AS build
COPY rollup.config.js .
COPY src/ ./src
RUN npm run build

# Release
FROM "821845795844.dkr.ecr.eu-west-1.amazonaws.com/base-images:node-14-17.5-alpine"
WORKDIR usr/src/app
COPY --from=dependencies /usr/src/app/package.json ./
RUN npm prune --production && npm install --only=production && rm package-lock.json
COPY --from=build /usr/src/app/dist ./dist
COPY .env .
CMD [ "node", "dist/bundle.js" ]