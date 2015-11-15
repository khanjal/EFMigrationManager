# EFMigrationManager

## Description
This powershell script manages entity framework migrations without the need to memorize all the commands.

## Features
* Choose currently installed dvnm versions.
* Pick DbContext if multiple exist.
* Add & Revert migrations.
* List migrations and dbContexts.
* Generate a script from migrations.

## Requirements
* ASP.NET 5
* EF 7

## Instructions
* Migrations are enabled by default for __ASP.NET Web Application__ projects. If you have an existing project, you can try the commands below to enable migrations.
 * Run the following commands in __Package Manager Console__
 * __Install-Package EntityFramework.Commands -Pre__ - make migration commands available.
 * __Enable-Migrations__ - enables migrations.
* Place powershell script in the project directory (.xproj) not the solution directory (.sln)
* Run script through powershell or package manager console.

## TODO
* Add comments to explain what's going on.
* Section code better.
* Add ability to choose dnvm versions with a number instead of typing it out.
* Create a possible error guide in case errors occur for common things.
* Choose a different DbContext from the initial one.
