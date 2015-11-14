# EFMigrationManager

## Description
This powershell script manages entity framework migrations without the need to memorize all the commands.

## Requirements
* ASP.NET 5
* EF 7

## Instructions
* Enable migrations in project - Run the following commands in __Package Manager Console__
  * __Install-Package EntityFramework.Commands -Pre__ - make migration commands available.
  * __Enable-Migrations__ - enables migrations.
* Place powershell script in the project directory (.xproj) not the solution directory (.sln)
* (Optional) Modify script to include appropriate __ContextKey__ if your project includes multiple DbContexts.
* Run script through powershell or package manager console.
