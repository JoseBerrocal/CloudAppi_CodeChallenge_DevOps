FROM node:7

## Step 1:
# Create a working directory
WORKDIR /app

## Step 2:
# Copy source code to working directory
COPY nodejs-server-server/package.json /app

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN npm install

COPY nodejs-server-server /app

## Step 4:
#Expose port 80
EXPOSE 8080

## Step 5:
# Run app.py at container launch
CMD [ "node", "index.js" ]