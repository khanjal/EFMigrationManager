# EFMigrationManager

## Description
This powershell script manages entity framework migrations without the need to memorize all the commands.

## Requirements
* EF 7

## Instructions
* Enable migrations on your project
  * Run the following commands in __Package Manager Console__ to enable migrations on your project
  * __Install-Package EntityFramework.Commands -Pre__ - make migration commands available in your project.
  * __Enable-Migrations__ - enables migrations in project.
* Place powershell script in the project directory (.xproj) not the solution directory (.sln)
* (Optional) Modify script to include appropriate __ContextKey__ if your project includes multiple DbContexts.
* Run script through powershell or package manager console.
