#################################################################################################################
#                              Created by: Diogo De Santana Jacome                                              #
#                                                                                                               #
#                              Modified by: Diogo De Santana Jacome                                             #
#                                                                                                               #
#                                                                                                               #
#                                          Version: 1.0                                                         #
#                                                                                                               #
#                                                                                                               #
#################################################################################################################

#initial requirements
###########################################################################################
Write-Host "You will be prompted for your account to access the subscription. " -ForegroundColor Yellow -BackgroundColor DarkRed
$ClientId = Read-Host "Enter the Service Principal Client ID or Account: " 
$ClientSecret = Read-Host "Enter the Service Principal ClientSecret or Password Account: "
$tenantid = Read-Host "Enter the Tenant ID: "
$xlsxPath = Read-Host "Export XLS: "

$listModules = @{ 
  'Az.Accounts'           = '2.7.1'
  'Az.Resources'          = '5.1.0'
  'Az.ResourceGraph'      = '0.12.0'
  'Az.Adm'                = '1.0.5'
  'ImportExcel'           = '7.5.3'
}

#validate that pwsh is ADM
function Test-Administrator {  
  [OutputType([bool])]
  param()
  process {
    [Security.Principal.WindowsPrincipal]$user = [Security.Principal.WindowsIdentity]::GetCurrent();
    return $user.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
  }
}

if (-not (Test-Administrator)) {
  #if pwsh is not as ADM, open it as ADM
  Write-Host 'pwsh is not as, trying to open as adm. If the Problem persists open poweshell as administrator and run it again' -ForegroundColor Yellow
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $testadmin = $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
  if ($testadmin -eq $false) {
    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    exit $LASTEXITCODE
  }
  if (-not (Test-Administrator)) {    

    Write-Host 'Unable to open pwsh as ADM, restart pwsh as ADM' -ForegroundColor DarkRed;
    exit 1;
  }
}


function CarregarModule ($Module, $Version) {
  
  
  
  ## Ensures that the necessary modules are working
  ## If the mudole is already imported continue
  Write-Host "module validating $Module version $Version whether it is installed and imported and its version." -ForegroundColor Green
  if (Get-Module  | Where-Object { $_.Name -eq $Module -and $_.Version -ge $Version }) {
    Write-Host "Module $Module is already imported in version $Version , Script Run." -ForegroundColor Gray
  }
  else {

    # Se o modulo ja estiver instalado e não importado
    if (Get-Module -ListAvailable | Where-Object { $_.Name -eq $Module -and $_.Version -ge $Version }) {
      Write-Host "Module $Module is not imported I will import it." -ForegroundColor Yellow
      Import-Module $Module 
      if (Get-Module | Where-Object { $_.Name -eq $Module -and $_.Version -ge $Version }) {
        Write-Host "Module $Module is already imported in version $Version , Script Run." -ForegroundColor Gray
      }
    }
    else {

      # Se o módulo não for importado, não estiver disponível no disco, mas estiver na galeria online, instale e importe
      if (Find-Module -Name $Module -RequiredVersion $Version | Where-Object { $_.Name -eq $Module -and $_.Version -match $Version }) {
        Write-Host "Module $Module is not installed, I will try to install it." -ForegroundColor Yellow
        Install-Module -Name $Module -RequiredVersion $Version -Force -Verbose -Scope CurrentUser
        Import-Module $Module -RequiredVersion $Version
        if (Get-Module | Where-Object { $_.Name -eq $Module -and $_.Version -ge $Version }) {
          Write-Host "Module $Module is already imported in version $Version , Script Run." -ForegroundColor Gray
        }
      }
      else {

        # Se não conseguir instalar aborte o script
        Write-Output "Module $Module not installed, check your Internet connection or try installing with the version $Version
              [$module][$Version]" -ForegroundColor DarkRed
        EXIT 1
      }
    }
  }
}


$VarModuleName = ($listModules).Keys

# Module Validate
foreach ($exe in $VarModuleName) {
  CarregarModule -module $exe -Version $listModules[$exe]
}



#connect in the AZ module
if (( $ClientID -ne '') -and ($ClientSecret -ne '')) {
  $SecuredPassword = ConvertTo-SecureString  $ClientSecret -AsPlainText -Force
  $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $ClientID, $SecuredPassword
  Connect-AzAccount -Credential $credential  -ServicePrincipal -TenantId $tenantid  -WarningAction SilentlyContinue | Out-Null
}
else {
  Connect-AzAccount  -WarningAction SilentlyContinue | Out-Null
}

#The Script
#################################################################################

$VM = (import-csv VirtualMachines.csv).Name
$Tags = @{Issue="Gmud-PatchApplication";env="prd";provision="IaC-Pwsh"}
Foreach ($VMS in $VM) {
  New-AzSnapshotDiskAll -VmName $VMS -Tag $Tags}



$SnapsId = (Get-AzResource -Tag $Tags).id
foreach ($SnapsIds  in $SnapsId ) {
  $exportXls = Get-AzSnapshot | Where-Object id  -eq $SnapsIds | Select-Object ResourceGroupName, Name, TimeCreated
  $exportXls | Export-Excel -Path "$xlsxPath" -WorksheetName 'Snapshots-Gmud' -AutoSize -TableStyle 'Light9' -FreezeTopRow -Append } 

