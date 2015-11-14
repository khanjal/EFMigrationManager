#Set this to your dbContext name
$dbContext = "DbContext"

# Colors
$infoColor = "Green"
$optionColor = "Yellow"
$titleColor = "Cyan"
$suggestionColor = "Magenta"

function CreateMigration 
{
	$name = Read-Host 'Migration name'
	dnx ef migrations add $name --context $dbContext
	Write-Host "Migration $name created." -foregroundcolor $infoColor
	Write-Host "Recommended actions: [A]pply or [D]elete" -foregroundcolor $suggestionColor
}

function ApplyMigration($name) 
{
	dnx ef database update $name -c $dbContext
	if ([String]::IsNullOrEmpty($name))
		{Write-Host "Migrations applied." -foregroundcolor $infoColor}
}

function DeleteMigration 
{
	dnx ef migrations remove --context $dbContext
	Write-Host "Migrations removed." -foregroundcolor $infoColor
}

function RevertMigration 
{
	$migrations = ListMigrations
	Write-Host "[C]ancel" -foregroundcolor $optionColor
	
	$number = Read-Host 'Migration number'
	
	if ($number -lt $migrations.length)
	{
		if ($number -eq 0) {$migration = $number}
		else {$migration = $migrations[$number]}

		ApplyMigration($migration)
		
		if ($migration -eq 0)
			{Write-Host "All migrations reverted." -foregroundcolor $infoColor}
		else
			{Write-Host "Migration reverted to $migration." -foregroundcolor $infoColor}
			
		Write-Host "Recommended actions: [D]elete or [A]pply" -foregroundcolor $suggestionColor
	}
}

function ListMigrations 
{
	Write-Host "Getting migrations..." -foregroundcolor $infoColor

	$migrations = dnx ef migrations list --context $dbContext | ToArray
	$migrations[0] = "All migrations"
	
	Write-Host $dbContext "migrations" -foregroundcolor $titleColor
	for ($i=0; $i -lt $migrations.length; $i++) {
		Write-Host "[$i]" $migrations[$i] -foregroundcolor $optionColor
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
		Write-Host "------Manage Migrations------" -foregroundcolor $titleColor
		Write-Host "[C]reate Migration" -foregroundcolor $optionColor
		Write-Host "[A]pply Migration" -foregroundcolor $optionColor
		Write-Host "[D]elete Migrations" -foregroundcolor $optionColor
		Write-Host "[L]ist Migrations" -foregroundcolor $optionColor
		Write-Host "[R]evert Migration" -foregroundcolor $optionColor
		Write-Host "[Q]uit" -foregroundcolor $optionColor
		Write-Host "-----------------------------" -foregroundcolor $titleColor
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
