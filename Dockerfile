FROM node:16-alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . . 
RUN npm run build 

FROM nginx 
#saying copy the build folder inside the app directory to the html directory inside the nginx container
COPY --from=builder /app/build /usr/share/nginx/html 

#for old aws config (not needed now as we are using docker-compose)
EXPOSE 80

# no need to specify a run command the default command for nginx starts the server