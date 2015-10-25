#Set this to your dbContext name
$dbContext = "DbContext"

function CreateMigration 
{
    $name = Read-Host 'Migration Name'
    dnx ef migrations add $name --context $dbContext
    Write-Host "Migration $name created."
}

function ApplyMigration($name) 
{
	dnx ef database update $name -c $dbContext
	Write-Host "Migration $name applied."
}

function DeleteMigration 
{
	dnx ef migrations remove --context $dbContext
	Write-Host "Migrations removed."
}

function RevertMigration 
{
	$migrations = ListMigrations
	$number = Read-Host 'Migration Number'
	
	if ($number -eq 0)
	{$migration = $number}
	else
	{$migration = $migrations[$number]}
	
	ApplyMigration($migration)
	Write-Host "Migration reverted to $migration."
}

function ListMigrations 
{
	Write-Host "Getting migrations..."
	$migrations = dnx ef migrations list --context $dbContext | ToArray
	$migrations[0] = "All Migrations"
	
	Write-Host $dbContext "Migrations"
	for ($i=0; $i -lt $migrations.length; $i++) {
		Write-Host "[$i]" $migrations[$i]
	}
	return $migrations
}

function Quit 
{
	#Write-Host "Press any key to continue ..."
	#$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Menu 
{
	Do {
		Write-Host "------Manage Migrations------"
		Write-Host "[C]reate Migration"
		Write-Host "[A]pply Migration"
		Write-Host "[D]elete Migrations"
		Write-Host "[L]ist Migrations"
		Write-Host "[R]evert Migration"
		Write-Host "[Q]uit"
		Write-Host "-----------------------------"
		$choice = read-host -prompt "Select option & press enter"
	} until ($choice -ne "")

	Switch ($choice) {
		"C" {
				CreateMigration
				Menu
			}
		"A" {
				ApplyMigration
				Menu
			}
		"D" {
				DeleteMigration
				Menu
			}
		"L" {
				ListMigrations > $null
				Menu
			}
		"R" {
				RevertMigration
				Menu
		}
		"Q" {Quit}
		default {Menu}
	}
}

function ToArray
{
  begin
  {
    $output = @(); 
  }
  process
  {
    $output += $_; 
  }
  end
  {
    return ,$output; 
  }
}

dnvm use 1.0.0-beta7
dnu restore
Menu
