FROM nginx:alpine

# Remove default NGINX content
RUN rm -rf /usr/share/nginx/html/*

# Copy your frontend files
COPY index.html index.js /usr/share/nginx/html/

# NGINX serves on port 80 by default
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
