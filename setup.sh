# Remove the git folder from the cloned repository
rm -rf .git/

# Install all composer dependencies
composer install

# Env
cp .env.example .env

# Run setup artisan commands
php artisan google-fonts:fetch
php artisan storage:link
php artisan migrate

yarn

# Retire this script.
rm setup.sh