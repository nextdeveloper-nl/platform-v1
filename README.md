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

 ### Step 1 : Cloning the project from GitHub account

  First, clone the Laravel project from GitHub and clone it into your project directory.
  Open the terminal:

  ```
    git clone https://github.com/nextdeveloper-nl/platform-v1.git
    cd <project_directory>
  ```
### Step 2 : Install composer dependencies

Let's use the following command to create the 'composer.json' file in the project.
Open the terminal and navigate to the project directory

```
  composer init
```

With this command, a 'composer.json' file is created and you will be prompted with various questions.

 1. Package name(<vendor>/<name>) : This is a step where you need to specify a unique name for the package you are creating. '<vendor>' -> It represents the person and organization creating the package.  '<name>' -> It represent the name of the created package.
 2. Description : Package description
 3. Author : It represents the information of the person creating the package
 4. Minimum Stability: Indicantes the stability level of the project. (stable,dev,alpha)
 5. Package Type : Package Type(project,library,laravel-package)
 6. License : Package licence (MIT,GPL,BSD)
 7. Would you like to define your dependencies(require) interactively?(yes/no): This question asks whether you want to define dependencies for the project. If you choose 'yes' you can define dependencies interactively. If you choose 'no' you ca add dependencies later by editing the 'composer.json' file
 . Would you like to define your dev dependencies(require-dev) interactively?(yes/no): Development dependencies

Then,
```
  composer install
```
This command installs the core dependencies of your Laravel project

```
  composer update
```
This command updates the changes made in the 'composer.json' file.

### Step 3 : Creating the '.env' file and generating the application key
 
 The '.env' file contains the basic configurations setting for your Laravel project.
 Open the terminal and navigate to the project directory

```
  touch .env
```
 This command creates the '.env' file.
**Note that:** The .env file is used to store configuration settings. It stores sensitive information(database password,production, test)

```
  php artisan key:generate
```
This command creates the APP_KEY.
**Note that** This command automatically generates the key setting in the config/app.php file and adds it to the .env file.

### Step 4 : Repository cloning and composer operations
 
 To clone a repository and include it in the project the following steps are followed:
 Navigate to the parent directory of the project in the terminal
       ```
            cd ..
            mkdir NextDeveloper
            cd NextDeveloper
            git clone https://github.com/nextdeveloper-nl/generator.git
            git clone https://github.com/nextdeveloper-nl/commons.git
            git clone https://github.com/nextdeveloper-nl/i18n.git
            git clone -b dev https://github.com/nextdeveloper-nl/iam.git
            cd ..
            cd <project_name>
      ```
  The repository versions used to in the 'require' section of the 'composer.json' file are automatically detected by composer
     
     ```
        "require": {
        ... 
            "nextdeveloper/commons": "@dev",
            "nextdeveloper/generator": "@dev",
            "nextdeveloper/i18n": "@dev",
        ...
        }
     ```

 ### Step 5: Adding the repository section
   
The 'repositories' section is added to the projects 'composer.json' file as follows:

```
    "repositories": [
        {
            "type": "path",
            "url": "../NextDeveloper/your-package",
            "options": {
                "symlink": true
            }
        }
    ]
```

**Note That** type: Specifies the repository type and should point to a local directory when 'path' is used.
**Note That** url: Specifies the path to the local direstory. This path should be specified relative to the folder where the projects 'composer.json' file is located.
**Note That** options: It is used to specify extra options. When the 'symlink' options is set to true composer adds the dependency as a symbolic link 
**Note That** This method is quite useful for testing packages or dependencies tahtyou develop locally during the development of your project. This way, you can quickly include changes from the local directory into your project.

The following command is used for changes in the 'composer.json' file:

 ```
   composer install
   composer update
 ```

### Running the project

```
  php artisan serve
```

## Running the project

Is as simle as:
```
php artisan octane:start
```

