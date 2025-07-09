# Step 1: Build the React app
FROM node:18-alpine AS build

WORKDIR /app

# Copy dependencies files first for better cache
COPY package.json package-lock.json* ./

RUN npm install

COPY . .

RUN npm run build

# Step 2: Serve the build with `serve`
FROM node:18-alpine

WORKDIR /app

RUN npm install -g serve

COPY --from=build /app/build ./build

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]
