#!/bin/bash

set -e

echo "⏳ Waiting for PostGIS database to boot..."

while ! nc -z db 5432; do
  sleep 0.5
done

echo "✅ PostGIS is online!"

echo "📦 Applying database migrations..."
python manage.py migrate

echo "🎨 Collecting static files..."
python manage.py collectstatic --noinput

exec "$@"