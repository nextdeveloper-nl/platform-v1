# About NextDeveloper Platform

Since we do have multiple teams on working multiple modules or projects (lets say), we had to find a way to work
together, as well as build a software that can be deployed all together. That is why came up with modular development
strategy.

## Who is NextDeveloper?
NextDeveloper is a team of developers from Netherlands, that is focusing on project management and high quality development.
This team has been working on automation and orchestration vertical for years, and we thought that it would be fun to
spin-off from the tech company called PlusClouds (Release the kraken!).
During these years we have been trying to find out the techniques for fast and bug free development.

## Modular development strategy

For that reason
in our automation projects we use Laravel to handle API requests and to make this strategy real, we came up with certain 
additional standarts to our own Laravel Platform. These standarts involves rules and templates that will 
help us to reduce the amount of actual coding, easing the actual learning curve and to reduce cost of development while
creating new module or a feature.

**Note that:** We are constantly maintaining this library so feel free to use it anywhere.

For instance according to our coding standarts, in a project there can be a platform, under that a module (or
product name), and feature of that product. Under the features, the applicaton development varies according the the need.

Thanks to this we can split products or sub projects (or modules) into different packages. To add other packages to the
application is as easy as adding the package name to the composer;

```
    "require": {
    ... 
        "nextdeveloper/account": "v1.*",
        "nextdeveloper/core": "v1.*",
    ...
    }
```

## Components

- PHP8.2
- Laravel
- Laravel Octane

## Project Setup

This covers cloning your Laravel project from GitHub, installing necessary dependencies, creating configuration files and running the project.

## Step 1 : Cloning the project from GitHub Account

To clone the relevant project from your GitHub account, you use the following command:

```
git clone https://github.com/nextdeveloper-nl/platform-v1.git
```
## Step 2 : Creating the 'composer.json' file and installing dependencies

Edit the `composer.json` file according to your needs and add the projects dependencies.


```
"repositories": [
            
            {
                "type": "path",
                "url": "../NextDeveloper/...",
                "options": 
                {
                    "symlink": true
                }
            }
            ...
        ]
    "require": { ... },
```

In this example\ a local dependency is defined in the `repositories` section, and external dependencies to be fetched from outside sources are specified in the `require` section.

To create a folder named `NextDeveloper` use the following command:

```
mkdir NextDeveloper
cd NextDeveloper
```
The cloning process from GitHub is performed for the required repositories

```
git clone https://github.com/nextdeveloper-nl/generator.git
git clone https://github.com/nextdeveloper-nl/commons.git
git clone https://github.com/nextdeveloper-nl/i18n.git
git clone -b dev https://github.com/nextdeveloper-nl/iam.git
cd ..
cd <project_name>
```
After completing the composer.json file.

```
composer install
```
The update the dependencies

```
composer update
```

## Step 3: Creating the '.env' file and generating an APP_KEY

Create a .env file in the projects root directory :

```
touch env
```
**Note that:** The .env file is used to store configuration settings. It stores sensitive information(database password,production, test)

To generate an 'APP_KEY'
```
php artisan key:generate  
```

**Note that** This command automatically generates the key setting in the config/app.php file and adds it to the .env file.

## Running the project

```
php artisan serve
```

## Running the project

Is as simle as:
```
php artisan octane:start
```

