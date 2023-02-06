Install-Module PowerShellGet -MinimumVersion "3.0.11-beta" -AllowPrerelease -Repository PSGallery -Force
Import-Module PowerShellGet
ls $Env:AZ
Publish-PSResource  -Path $Env:AZ/Az.Adm -Repository PSGallery -apikey $Env:APIKEY