# Base image (OS)
#
FROM node:23-alpine3.20 AS builder
#
# # Working directory

WORKDIR /app

# Copy code from local to container

COPY . .

#Run the  application

RUN npm install


# Build the React application
RUN npm run build


#Stage 2 (where we have a a code and the code dependencies without linux distribution)

FROM gcr.io/distroless/nodejs18-debian12

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules


EXPOSE 3000

CMD ["./node_modules/.bin/serve", "-s", "dist", "-l", "3000"]


 

