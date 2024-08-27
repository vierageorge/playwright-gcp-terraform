FROM mcr.microsoft.com/playwright:v1.46.1-jammy
WORKDIR /app

ENV CI true

# Set the environment path to node_modules/.bin
ENV PATH /app/node_modules/.bin:$PATH

# COPY the needed files to the app folder in Docker image
COPY tests/ /app/tests/
COPY package.json yarn.lock tsconfig.json playwright.config.ts /app/

# Install dependencies
RUN yarn --frozen-lockfile
ENTRYPOINT [ "yarn", "test" ]