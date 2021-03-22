#build stage
FROM node:latest as build-stage
RUN cd /var/ && git clone https://github.com/NeoKms/siteBuilderFront.git
WORKDIR /var/siteBuilderFront/
RUN npm install
RUN npm run build

#production-stage
FROM nginx:stable-alpine as production-stage
#FROM nginx:latest as production-stage
COPY --from=build-stage /var/siteBuilderFront/dist /usr/share/nginx/html
COPY --from=build-stage /var/siteBuilderFront/getenv.sh /usr/share/nginx/html/getenv.sh
COPY --from=build-stage /var/siteBuilderFront/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
