Install-Module PowerShellGet -RequiredVersion "3.0.11-beta" -AllowPrerelease -Repository PSGallery -Force
Import-Module PowerShellGet -RequiredVersion "3.0.11"
ls $Env:AZ
Publish-PSResource  -Path $Env:AZ/Az.Adm -Repository PSGallery -apikey $Env:APIKEY