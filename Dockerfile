ARG PHP_VERSION=8.4
FROM php:${PHP_VERSION}-apache

# 1. Системные зависимости для GD, Zip и Git
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Настройка конфигурации графической библиотеки GD
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp

# 3. Установка всех необходимых расширений (MySQL, GD, Zip)
RUN docker-php-ext-install zip pdo_mysql mysqli gd

# 4. Установка и включение Xdebug для отладки в VS Code
RUN pecl install xdebug && docker-php-ext-enable xdebug

# 5. Включение модуля mod_rewrite для работы красивых ссылок / .htaccess
RUN a2enmod rewrite