FROM nginx:1.27.0

# Install the GNU Compiler Collection
RUN apt-get update && apt-get install -y \
        gcc mono-mcs \
    && rm -rf /var/lib/apt/lists/* \
    && rm  /etc/nginx/conf.d/default.conf \
    # Create the necessary directories
    && mkdir -p /var/cache/nginx/client_temp \
        /var/cache/nginx/proxy_temp \
        /var/cache/nginx/fastcgi_temp \
        /var/cache/nginx/scgi_temp \
        /var/cache/nginx/uwsgi_temp \
        /etc/nginx/sites-available \
        /etc/nginx/sites-enabled \
        /etc/nginx/blocklists \
        /etc/nginx/snippets \
        /srv/http/default/snippets \
    # Claim ownership for the NGINX user
    && chown -R nginx:nginx /usr/share/nginx \
    && chown -R nginx:nginx /etc/nginx

# Copy the NGINX configuration files
ADD wordpress.conf /etc/nginx/sites-available
ADD error.conf /srv/http/default/snippets
ADD pages.conf /srv/http/default/snippets
ADD nginx.pid /var/log/nginx
ADD nginx.conf /etc/nginx

# Create the symbolic link
RUN ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/wordpress.conf
RUN ln -s /srv/http/default/snippets/error.conf /etc/nginx/snippets/error.conf
RUN ln -s /srv/http/default/snippets/pages.conf /etc/nginx/snippets/pages.conf

# Set the working directory
WORKDIR /data

# Switch to the NGINX user
USER nginx