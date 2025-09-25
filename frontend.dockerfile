FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY index.html index.js ./

EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
