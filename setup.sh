# Remove the git folder from the cloned repository
rm -rf .git/

# Install all composer dependencies
composer install

# Env
cp .env.example .env

echo "Please take a moment to set up your .env file."
read -p "Press enter to continue."

# Run setup artisan commands
php artisan google-fonts:fetch
php artisan storage:link
php artisan migrate

yarn

# Retire this script.
rm setup.sh