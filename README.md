# Northstar Studio — Laravel Demo Project

A responsive four-page business website built with Laravel 12, PHP, Blade, MySQL, Bootstrap 5, CSS and JavaScript. Northstar Studio is a **fictional studio created for a developer portfolio demo**. Sample copy is illustrative; there are no client claims or testimonials.

## Pages

- `/` — Home
- `/about` — Studio story and principles
- `/services` — Brand, design and development services
- `/contact` — Validated contact form with MySQL message storage

The shared responsive navigation and footer appear on every page. Bootstrap and icon styles, Google Fonts, and the sample workspace photography load from external CDNs.

## Run locally

Requirements: PHP 8.2+, Composer, and MySQL. From the project directory:

1. Create a MySQL database named `northstar_demo`.
2. Copy `.env.example` to `.env` if needed and set `DB_HOST`, `DB_PORT`, `DB_DATABASE`, `DB_USERNAME`, and `DB_PASSWORD` for your local MySQL server.
3. Install dependencies and generate an application key:

   ```sh
   composer install
   php artisan key:generate
   ```

4. Create the contact-message table and start the local server:

   ```sh
   php artisan migrate
   php artisan serve
   ```

5. Open the URL printed by `php artisan serve`.

The contact form validates and rate-limits submissions before saving them. Configure a real database and review mail, privacy, and deployment settings before adapting this portfolio demo for production.

## Tests

```sh
php artisan test
```
