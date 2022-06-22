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

$ClientId = Read-Host "Enter the Service Principal Client ID: " 
$ClientSecret = Read-Host "Enter the Service Principal ClientSecret: "
$tenantid = Read-Host "Enter the Tenant ID: "
$tanantname = Read-Host "Enter the Tenant Name: "
$xlsxPath = Read-Host "Export XLS: "


$listModules = @{ 
  'Az.Accounts'           = '2.7.1'
  'Az.Resources'          = '5.1.0'
  'Az.ResourceGraph'      = '0.12.0'
  'ImportExcel'           = '7.5.3'
  'Microsoft.Graph.Users' = '1.9.6'
  'JoinModule'            = '3.7.2'
  'Az.Adm'                = '1.0.5'
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

#collecting all users and replace is due to the uri API that the Az.Adm Module consumes from Graph
$UserAllUpn = (Get-AzADUser).UserPrincipalName 
$UserUpnAll = $UserAllUpn.replace('#', '%23')

#Checked MFA,AD Role, E-mail, Last login, locked user and Subscription access in parelo of 50 users
#You must use a limiter of 50 users for tenants with more than 300 users
#You may need to pass the credentials again inside 
$ReportsUsersList = $UserUpnAll | ForEach-Object  -ThrottleLimit 50 -Parallel {
  Get-AzGraphUserRbac -upn $_ -ClientID  $ClientID -ClientSecret $ClientSecret -tenantdomain $tanantname  -TenantId $tenantid
  Start-Sleep -Seconds 20
}

#Collecting all the group ids that give administrative permissions on the subscription
$GroupRbac = Get-AzRoleAssignment -WarningAction SilentlyContinue | Where-Object ObjectType -EQ Group | Select-Object -ExpandProperty ObjectId    | Get-Unique -AsString

$RbacGpUserAll = $GroupRbac | ForEach-Object -ThrottleLimit 50 -Parallel {
  Get-AzADGroupRBAC -Group $_
}  


#Creating Class to support replace #ext# to %23ext%23, for API processing
class record {
  [string]$mail
}

$recordList = New-Object Collections.Generic.List[record]

foreach ($LoopGpRbac in $GroupRbac) {
  $GpMemberMail = (Get-AzADGroupMember -GroupObjectId $LoopGpRbac).Id
  foreach ($LoopGpMemberMail in $GpMemberMail) {
    $UPNUser = (Get-AzADUser -ObjectId $LoopGpMemberMail).UserPrincipalName
    $UPNUserEXE = $UPNUser.replace('#', '%23')
    $record = [record]::new()
    $record.mail = $UPNUserEXE
    $recordList.add($record)
  }

}

$uniqueRbacUser = ($recordList | Sort-Object -Property mail -Unique ).mail

#Checked MFA,AD Role, E-mail, Last login, locked user and Subscription access in parelo of 50 users
#You must use a limiter of 50 users for tenants with more than 300 users
#You may need to pass the credentials again inside 
$RbacGPList = $uniqueRbacUser  | ForEach-Object -ThrottleLimit 50 -Parallel {
  
  Get-AzGraphUser  -upn $_ -ClientID  $ClientId  -ClientSecret $ClientSecret  -tenantdomain $tanantname
  Start-Sleep -Seconds 20
}


#Export Configuration to Excel
$ListAll = ($RbacGpUserAll | Merge-Object $RbacGPList -On SignInName)
$ListAll = $ListAll | Select-Object Name, SignInName, MFADefault, MFAMethods, MFASmsEnabled, MFANumber, license , RoleADAssignedUser, RoleDefinitionName, Scope, 'associated Group', DN, AccoutCreate, UserLestlogin, AccountEnabled


if ($ReportsUsersList.MFADefault -eq '') {
  $MFAEnable = $ReportsUsersList | Where-Object MfADefault -EQ ''
}

if ($ReportsUsersList.MFADefault -ne '') {
  $MFADisable = $ReportsUsersList | Where-Object MfADefault -NE ''
}

$MFAEnable | Export-Excel -Path "$xlsxPath" -WorksheetName 'MFA - Enable' -AutoSize -TableStyle 'Light9' -FreezeTopRow -Append
$MFADisable | Export-Excel -Path "$xlsxPath" -WorksheetName 'MFA - False' -AutoSize -TableStyle 'Light9' -FreezeTopRow -Append
$ListAll | Export-Excel -Path "$xlsxPath" -WorksheetName 'Rbac Group - MFA' -AutoSize -TableStyle 'Light9' -FreezeTopRow -Append