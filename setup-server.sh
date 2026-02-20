#!/bin/bash

# Portfolio Server Setup Script
# Run as root on the same droplet as directory_factory
# Usage: bash setup-server.sh

set -e

echo "=== Portfolio Server Setup ==="

# 1. Clone portfolio into /var/www/portfolio
echo "Setting up portfolio files..."
mkdir -p /var/www/portfolio

if [ -d /var/www/portfolio/.git ]; then
  echo "Portfolio repo already exists, pulling latest..."
  cd /var/www/portfolio
  git pull origin main
else
  echo "Cloning portfolio repo..."
  git clone https://github.com/nigelmcintyre/portfolio.git /var/www/portfolio
fi

# 2. Copy Nginx config
echo "Setting up Nginx..."
cp /var/www/portfolio/nginx-portfolio.conf /etc/nginx/sites-available/portfolio
ln -sf /etc/nginx/sites-available/portfolio /etc/nginx/sites-enabled/portfolio

# 3. Test and reload Nginx
echo "Testing Nginx configuration..."
nginx -t

echo "Reloading Nginx..."
systemctl reload nginx

# 4. SSL with Certbot
echo ""
echo "=== Setup Complete ==="
echo ""
echo "NEXT STEP: Run the following command to set up SSL:"
echo "  certbot --nginx -d simplesitesolutions.ie -d www.simplesitesolutions.ie"
echo ""
echo "After that, your site will be live at https://simplesitesolutions.ie"
echo ""
