Install-Module PowerShellGet -MinimumVersion "3.0.11-beta" -AllowPrerelease -Repository PSGallery -Force
Import-Module PowerShellGet
Publish-PSResource  -Path $Env:PATH/Az.Adm -Repository PSGallery -apikey $Env:APIKEY