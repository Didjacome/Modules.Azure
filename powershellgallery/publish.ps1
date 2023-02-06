Install-Module PowerShellGet -version "3.0.11-beta" -AllowPrerelease -Repository PSGallery -Force
Import-Module PowerShellGet
Publish-PSResource  -Path $Env:PATH -Repository PSGallery -apikey $Env:APIKEY