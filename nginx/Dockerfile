FROM nginx:1.25.5

# Install the GNU Compiler Collection and create cache directories
RUN apt-get update && apt-get install -y \
        gcc mono-mcs \
    && rm -rf /var/lib/apt/lists/*

# Create the necessary directories
RUN mkdir -p /var/run/nginx \
    /var/cache/nginx/client_temp \
    /var/cache/nginx/proxy_temp \
    /var/cache/nginx/fastcgi_temp \
    /var/cache/nginx/scgi_temp \
    /var/cache/nginx/uwsgi_temp \
    /usr/share/nginx/html/blocklists \
    /usr/share/nginx/html/sites-enabled

# Copy the NGINX configuration files
ADD staging /usr/share/nginx/html/sites-enabled
ADD conf.d/default.conf /etc/nginx/conf.d
ADD nginx.pid /var/run/nginx
ADD nginx.conf /etc/nginx

# Claim ownership for the NGINX user
RUN chown -R nginx:nginx /etc/nginx

# Set the working directory
WORKDIR /usr/share/nginx/html

# Switch to the NGINX user
USER nginx