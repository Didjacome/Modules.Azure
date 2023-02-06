cd $Env:path
$ModulePath = "$PSScriptRoot\Az.Adm"
Publish-Module -Path $ModulePath -NuGetApiKey $Env:APIKEY