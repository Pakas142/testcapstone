FROM node:16-alpine AS build
WORKDIR /usr/app
COPY . /usr/app
RUN npm install
RUN npm run build


FROM nginx:1.21-alpine
RUN rm /usr/share/nginx/html/index.html
COPY --from=build /usr/app/my-app/build/* /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
