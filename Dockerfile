FROM node:18 AS buildingstage  

WORKDIR /app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx:latest

COPY ./nginxConfigs/default.conf /etc/nginx/conf.d/default.conf

COPY --from=buildingstage /app/dist /usr/share/nginx/html

## i prefered this for more security than predoing it and pushing it to the repo(ask if i should do it in server) 
WORKDIR /etc/nginx/dhparam 

RUN openssl dhparam -out dhparam-2048.pem 2048

EXPOSE 80
EXPOSE 443
