Get-Module -ListAvailable
Install-Module PowerShellGet -MinimumVersion "3.0.11-beta" -AllowPrerelease -Repository PSGallery -Force
Get-Module -ListAvailable
Import-Module PowerShellGet
Publish-PSResource  -Path $Env:PATH -Repository PSGallery -apikey $Env:APIKEY