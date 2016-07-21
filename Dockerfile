# Using Node 5.12 because the current Harp release doesn't support 6.x
FROM node:5.12.0

# Create our workspace
RUN mkdir -p /usr/src
WORKDIR /usr/src

# Bring over our package.json to get started
COPY package.json /usr/src

# Configure npm to be quiet-ish on install and then install
RUN npm install --quiet

EXPOSE 9000
CMD ["npm", "start"]
