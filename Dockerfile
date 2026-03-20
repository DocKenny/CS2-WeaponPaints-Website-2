# Use the official Nixpacks Ubuntu base (same as Dokploy uses)
FROM ghcr.io/railwayapp/nixpacks:ubuntu-1745885067

# Set the working directory
WORKDIR /app

# Copy the entire application (the build context will be filtered by .dockerignore)
COPY . .

# Make the whole application writable by the user that will run PHP (uid 1000)
RUN chown -R 1000:1000 /app && chmod -R 775 /app

# Switch to the non‑root user
USER 1000

# Use the default Nixpacks start command
CMD ["/bin/bash", "-c", "node /assets/scripts/prestart.mjs /assets/nginx.template.conf /nginx.conf && (php-fpm -y /assets/php-fpm.conf & nginx -c /nginx.conf)"]
