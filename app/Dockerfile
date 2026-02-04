FROM node:18-alpine

WORKDIR /app


COPY package*.json ./

# Install dependencies
RUN npm ci --only=production


COPY . .

EXPOSE 3000

CMD ["npm", "start"]
