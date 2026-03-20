# Use the official Nixpacks Ubuntu base
FROM ghcr.io/railwayapp/nixpacks:ubuntu-1745885067

WORKDIR /app

# Copy the application
COPY . .

# Fix ownership and permissions for the whole app directory
RUN chown -R 1000:1000 /app && chmod -R 775 /app

# Create a startup script that keeps the container running
# (do this while still root, so we can write to /app)
RUN echo '#!/bin/bash\n\
node /assets/scripts/prestart.mjs /assets/nginx.template.conf /nginx.conf\n\
php-fpm -y /assets/php-fpm.conf &\n\
nginx -c /nginx.conf\n\
wait' > /app/start.sh && chmod +x /app/start.sh

# Switch to the non‑root user
USER 1000

# Use the startup script
CMD ["/app/start.sh"]
