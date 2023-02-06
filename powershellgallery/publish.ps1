Get-Module -ListAvailable
Import-Module PowerShellGet
Publish-PSResource  -Path $Env:PATH -Repository PSGallery -apikey $Env:APIKEY