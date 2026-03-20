# Use the official Nixpacks Ubuntu base
FROM ghcr.io/railwayapp/nixpacks:ubuntu-1745885067

WORKDIR /app

# Copy the application
COPY . .

# Fix ownership and permissions
RUN chown -R 1000:1000 /app && chmod -R 775 /app

# Switch to the non‑root user
USER 1000

# Create a startup script that keeps the container running
RUN echo '#!/bin/bash\n\
node /assets/scripts/prestart.mjs /assets/nginx.template.conf /nginx.conf\n\
php-fpm -y /assets/php-fpm.conf &\n\
nginx -c /nginx.conf\n\
wait' > /start.sh && chmod +x /start.sh

CMD ["/start.sh"]
