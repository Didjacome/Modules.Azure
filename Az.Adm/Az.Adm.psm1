<#
 	.SYNOPSIS
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
      Get-AzAdGroupRrbac is an advanced function that can be used to check all users of groups that have RBAC permission
    
    .DESCRIPTION
      Get-AzAdGroupRbac is an advanced function that can be used to check all users of groups that have RBAC permission

      You need to be connected to Azure subscription 

      You need to have role Reader permission on Azure subscription and in Azure AD



    
    .EXAMPLE
      C:\PS> Get-AzAdGroupRbac -Import .\AZAD_Groups.csv
				
    .EXAMPLE
      C:\PS> Get-AzAdGroupRbac -Group GP-Ower

    .EXAMPLE
      C:\PS> Get-AzAdGroupRbac -Group xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    
    .EXAMPLE
      C:\PS> Get-AzAdGroupRbac -Import .\AZAD_Groups.csv |  Export-Csv C:\Users\$env:USERNAME\Documents\GroupUserAll.csv
		.LINK 
      https://github.com/Didjacome

	
        
#>
function  Get-AzAdGroupRbac {

  [CmdletBinding(DefaultParameterSetName = 'Group')]
  
  param(
    [Parameter(Mandatory, ParameterSetName = 'Group')]
    [string]
    $Group,
   
   
    [Parameter(Position = 0,
      Mandatory, ValueFromPipelineByPropertyName,
      ValueFromPipeline, ParameterSetName = 'import')]
    [string]
    $Import
  )
 
  process {
   
    
   
   
    Write-Verbose "ParameterSetName is '$($PSCmdlet.ParameterSetName)'"
    if ( $PSCmdlet.ParameterSetName -eq 'import' ) { 
      
      $Validar_Import = Test-Path $Import -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
      
      if ( $Validar_Import -eq $true) {
        

        function matrizContar ($inicio, $final, $de, $var2) {
          $contagem = $inicio 
          while ($contagem -le $final) {
            $RoleGroup = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).RoleDefinitionName[$contagem] 
          
            $ScopeRBAC = (Get-AzRoleAssignment -WarningAction SilentlyContinue   |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).Scope[$contagem]
      
            $GroupAssignment = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).DisplayName[$contagem]
      
            $Id = Get-AzADGroupMember -GroupDisplayName $var2  | Select-Object -ExpandProperty Id           
            foreach ($ver in $id) { Get-AzADUser -ObjectId $ver | Select-Object  @{n = 'SignInName'; e = { $_.Mail } }, @{n = 'RoleDefinitionName'; e = { "$RoleGroup" } }, @{n = 'Scope'; e = { "$ScopeRBAC" } }, @{n = 'associated Group'; e = { "$GroupAssignment" } } }              
            $contagem += $de            
          }
        }

        $i = 0
        $p = 1
        $rep = (Import-Csv $Import -UseCulture | Select-Object DisplayName | Sort-Object DisplayName | Get-Unique -AsString).DisplayName

        foreach ($d in $rep) {
          $countGp = (Get-Content $Import | Select-String -Pattern $d -CaseSensitive -SimpleMatch ).count ; $f = $countGp - 1 ;
          matrizContar -inicio $i -final $f -de $p -var $d
        }

      }
      else {
        Write-Host [' Csv import error
   
       Please go to ''https://github.com/Didjacome']  -ForegroundColor DarkRed
      }

    }
 
    if ( $PSCmdlet.ParameterSetName -eq 'Group' ) {
    
      $ValidarGP = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object DisplayName -Like $Group | Get-Unique -AsString ).DisplayName
      
      
      if ( $ValidarGP -like $Group ) {
     
        function matrizContar ($inicio, $final, $de, $var2) {
          $contagem = $inicio 
          while ($contagem -le $final) {
            $RoleGroup = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).RoleDefinitionName[$contagem] 
          
            $ScopeRBAC = (Get-AzRoleAssignment -WarningAction SilentlyContinue   |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).Scope[$contagem]
      
            $GroupAssignment = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).DisplayName[$contagem]
      
            $id = Get-AzADGroupMember -GroupDisplayName $var2  | Select-Object -ExpandProperty Id             
            foreach ($ver in $id) { Get-AzADUser -ObjectId $ver | Select-Object  @{n = 'SignInName'; e = { $_.Mail } }, @{n = 'RoleDefinitionName'; e = { "$RoleGroup" } }, @{n = 'Scope'; e = { "$ScopeRBAC" } }, @{n = 'associated Group'; e = { "$GroupAssignment" } } }              
            $contagem += $de            
          }
          
        }

        $i = 0
        $p = 1
        $rep = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object DisplayName -Like $Group | Get-Unique -AsString ).DisplayName

        foreach ($d in $rep) {
          $countGp = ((Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object DisplayName -Like $d).ObjectId).count ; $f = $countGp - 1 ;
          matrizContar -inicio $i -final $f -de $p -var $d
        }



      }

      else {
        
        $validarGPId = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object ObjectId -Like $Group | Get-Unique -AsString ).ObjectId
        if ($validarGPId -eq $Group) {
       
          function matrizContar ($inicio, $final, $de, $var2) {
            $contagem = $inicio 
            while ($contagem -le $final) {
              $RoleGroup = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  ObjectId -EQ $var2).RoleDefinitionName[$contagem] 
          
              $ScopeRBAC = (Get-AzRoleAssignment -WarningAction SilentlyContinue   |  Where-Object ObjectType -EQ Group | Where-Object  ObjectId -EQ $var2).Scope[$contagem]
      
              $GroupAssignment = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  ObjectId -EQ $var2).DisplayName[$contagem]
      
              $Id = Get-AzADGroupMember  -GroupObjectId $var2  | Select-Object -ExpandProperty Id             
              foreach ($ver in $Id) { Get-AzADUser -ObjectId $ver | Select-Object  @{n = 'SignInName'; e = { $_.Mail } }, @{n = 'RoleDefinitionName'; e = { "$RoleGroup" } }, @{n = 'Scope'; e = { "$ScopeRBAC" } }, @{n = 'associated Group'; e = { "$GroupAssignment" } } }              
              $contagem += $de            
            }
          
          }
          $i = 0
          $p = 1
          $rep = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object ObjectId -Like $Group | Get-Unique -AsString ).ObjectId

          foreach ($d in $rep) {
            $countGp = ((Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object ObjectId -Like $d).ObjectId).count ; $f = $countGp - 1 ;
            matrizContar -inicio $i -final $f -de $p -var $d
          }
        }
      


        else {
          Write-Host ['Group does not exist
 
        Please go to ''https://github.com/Didjacome'] -ForegroundColor DarkRed
        }
      }

    }
     
      
  }
}



<#
 	.SYNOPSIS
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
      Set-AzTag is an advanced function that can be used to configure tags on all resources in a resource group
    
    .DESCRIPTION
      Set-AzTag is an advanced function that can be used to configure tags on all resources in a resource group

      You need to be signed in to the Azure subscription

      You need to have permission on the Azure subscription
    
    .EXAMPLE
      C:\PS> Set-AzTag -RG "My Resource Group Name" -ImportCSV .\Tags.csv
				
    .EXAMPLE
      C:\PS> Set-AzTag -RG "My Resource Group Name" -Tag_Name Env -Tag_value PRD
    

		.LINK 
      https://github.com/Didjacome

	
        
#>
function Set-AzTag {


  [CmdletBinding(DefaultParameterSetName = 'TAG')]

  param (
    # Parameter help description
    [Parameter(Mandatory)]
    [System.String]
    $RG,

    [Parameter(Mandatory, ParameterSetName = 'TAG')]
    [System.String]
    $Tag_Name,
    
    [Parameter(Mandatory, ParameterSetName = 'TAG')]
    [System.String]
    $Tag_Value,

    [Parameter(Position = 0,
      Mandatory, ValueFromPipelineByPropertyName,
      ValueFromPipeline, ParameterSetName = 'CSV')]
    [System.String]
    $ImportCSV


  )

  process {
    

    Write-Verbose "ParameterSetName is '$($PSCmdlet.ParameterSetName)'"

    if ($PSCmdlet.ParameterSetName -eq 'TAG') {

      $tags = @{$Tag_Name = $Tag_Value }

      $rg_id = (Get-AzResourceGroup -Name $RG).ResourceId
  
      $all_resource_id = (Get-AzResource -ResourceGroupName $RG).ResourceId
      
      Update-AzTag -ResourceId $rg_id -Tag $tags -Operation Merge

      foreach ( $resource in $all_resource_id ) {

        Update-AzTag -ResourceId $resource -Tag $tags  -Operation Merge

      }
    }

    if ($PSCmdlet.ParameterSetName -eq 'CSV') {

      function convertCsvToHashTable($ImportCSV) {
        $csv = Import-Csv $ImportCSV -UseCulture
        $headers = $csv[0].psobject.properties.name
        $key = $headers[0]
        $value = $headers[1]
        $hashTable = @{}
        $csv | ForEach-Object { $hashTable[$_."$key"] = $_."$value" }
        return $hashTable
      }

      $tags = convertCsvToHashTable $ImportCSV

      $rg_id = (Get-AzResourceGroup -Name $RG).ResourceId

      $all_resource_id = (Get-AzResource -ResourceGroupName $RG).ResourceId

      Update-AzTag -ResourceId $rg_id -Tag $tags -Operation Merge

      foreach ( $resource in $all_resource_id ) {

        Update-AzTag -ResourceId $resource -Tag $tags  -Operation Merge

      }
    }
  
  }   
}



<#
 	.SYNOPSIS
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
      Convert-CsvToHashtable is an advanced function that converts CSV to HashTable
    
    .DESCRIPTION
      Convert-CsvToHashtable is an advanced function that converts CSV to HashTable
    
    .EXAMPLE
      C:\PS> Convert-CsvTohashtable -Path .\variavel.csv
				
		.LINK 
      https://github.com/Didjacome

	
        
#>
function Convert-CsvTohashtable {
  param (
    # Parameter help description
    [Parameter(Mandatory)]
    [System.String]
    $Path
  )

  process {

    $csv = Import-Csv $Path -UseCulture
    $headers = $csv[0].psobject.properties.name
    $key = $headers[0]
    $value = $headers[1]
    $hashTable = @{}
    $csv | ForEach-Object { $hashTable[$_."$key"] = $_."$value" }
    return $hashTable

  }
}



<#
 	.SYNOPSIS
      #################################################################################################################
      #                              Created by: Diogo De Santana Jacome                                              #
      #                              Co-creator: Luan Victor Cordeiro Levandoski                                      #
      #                              Modified by: Diogo De Santana Jacome                                             #
      #                                                                                                               #
      #                                                                                                               #
      #                                          Version: 1.0                                                         #
      #                                                                                                               #
      #                                                                                                               #
      #################################################################################################################   
      Get-AzGraphUserRbac is an advanced function that can be used to verify all users, MFA, MS 365 license, Azure AD role, Azure subscription role, last login, user lock.
    
    .DESCRIPTION
      Get-AzGraphUserRbac is an advanced function that can be used to verify all users, MFA, MS 365 license, Azure AD role, Azure subscription role, last login, user lock.

      You need a Service Principal that can access the graph API. API Permissions:
      AuditLog.Read.All
      Directory.Read.All
      Group.Read.All
      User.Read.All
      UserAuthenticationMethod.Read.All


      You need to have role Reader permission on Azure subscription and in Azure AD

      This function will download a CSV spreadsheet about the Microsoft Upgraded license

      Licensing-service-plan-reference: https://docs.microsoft.com/En-us/azure/active-directory/enterprise-users/licensing-service-plan-reference



    
    .EXAMPLE
      C:\PS> Get-AzGraphUserRbac -upn test@contoso.onmicrosoft.com -tenantdomain contoso.onmicrosoft.com -ClientID 00000000-0000-0000-0000-00000000 -ClientSecret 0000zzzz0000zzzz0000zzzz -tenantid xxxxx-xxxxx-xxxxxx-xxxxx
				
    .EXAMPLE
      C:\PS> Get-AzGraphUserRbac -upn test@contoso.onmicrosoft.com -tenantdomain contoso.onmicrosoft.com -ClientID 00000000-0000-0000-0000-00000000 -ClientSecret 0000zzzz0000zzzz0000zzzz -tenantid xxxxx-xxxxx-xxxxxx-xxxxx | export-csv report-security.csv
    
    .EXAMPLE
      C:\PS> $User_Ext = (Get-AzADUser |  Where-Object UserPrincipalName  -Like '*#EXT#@*').UserPrincipalName
      C:\PS> $User_Ext_ALL = $User_Ext.replace('#', '%23')
      C:\PS> Foreach ( $Users in $User_Ext_ALL){
             Get-AzGraphUserRbac -upn $Users -tenantdomain contoso.onmicrosoft.com -ClientID 00000000-0000-0000-0000-00000000 -ClientSecret 0000zzzz0000zzzz0000zzzz -tenantid xxxxx-xxxxx-xxxxxx-xxxxx}

		.LINK 
      https://github.com/Didjacome

	
        
#>
function Get-AzGraphUserRbac {
  param (
    [Parameter(Mandatory)]
    [string]$upn,
    [Parameter(Mandatory)]
    [String]$tenantdomain,
    [Parameter(Mandatory)]
    [string]$ClientSecret,
    [Parameter(Mandatory)]
    [string]$ClientID,
    [Parameter(Mandatory)]
    [string]$tenantid  
  )
  
  [string]$select = 'select'
  [string]$filter = 'filter'
  [string]$cifrao = '$'
  [string]$cf = $cifrao + $filter
  [string]$cs = $cifrao + $select
    
  $Uri_MS_License = 'https://download.microsoft.com/download/e/3/e/e3e9faf2-f28b-490a-9ada-c6089a1fc5b0/Product%20names%20and%20service%20plan%20identifiers%20for%20licensing.csv'
  $File_CSV_License = 'license.csv'
  if ((Test-Path $File_CSV_License) -eq $false) {
    Invoke-WebRequest -Uri $Uri_MS_License -OutFile $File_CSV_License
    $data = Import-Csv $File_CSV_License
  }
  else {
    $data = Import-Csv $File_CSV_License
  }

  class ReportsUsers {
    [string]$name
    [string]$email
    [string]$MFADefault
    [string]$MFAMethods
    [string]$MFASmsEnabled
    [string]$MFANumber
    [string]$license
    [string]$RoleADAssignedUser
    [string]$RoleRbacName
    [string]$RolesRbacScope
    [string]$DN
    [string]$AccoutCreate
    [string]$UserLestlogin
    [string]$AccountEnabled
  }
    
  $ReportsUsersList = New-Object Collections.Generic.List[ReportsUsers]
  
  class LicenseAll {
    [string]$LicenseNameAll
  }
  
  $LicenseAllList = New-Object Collections.Generic.List[LicenseAll]

  $loginURL = 'https://login.microsoftonline.com'
  $resource = 'https://graph.microsoft.com'           # Microsoft Graph API resource URI

  $body = @{grant_type = 'client_credentials'; resource = $resource; client_id = $ClientID; client_secret = $ClientSecret }
  $oauth = Invoke-RestMethod -Method Post -Uri $loginURL/$tenantdomain/oauth2/token?api-version=1.0 -Body $body
  if ($oauth.access_token -ne $null) {
    $headerParams = @{'Authorization' = "$($oauth.token_type) $($oauth.access_token)" }

    $MFA_url = "https://graph.microsoft.com/beta/reports/authenticationMethods/userRegistrationDetails?$cf=userPrincipalName eq '$upn'"
    $mfa = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $MFA_url)

    $MFASMS_URL = "https://graph.microsoft.com/beta/users/$upn/authentication/phoneMethods"
    $SMS = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $MFASMS_url)


    $User_url = "https://graph.microsoft.com/beta/users?$cf=userPrincipalName eq '$upn'" 
    $User = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $User_url)

    $Sing_url = "https://graph.microsoft.com/beta/users?$cf=userPrincipalName eq '$upn'&$cs=signInActivity" 
    $Sing = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $Sing_url)


    $license_url = "https://graph.microsoft.com/v1.0/users/$upn/licenseDetails"
    $license = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $license_url)

    $role_url = "https://graph.microsoft.com/beta/users/$upn/transitiveMemberOf/microsoft.graph.directoryRole?$cs=displayName"
    $role = Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $role_url  -SkipHttpErrorCheck -SkipHeaderValidation

  }
  else {
    Write-Host 'ERROR: No Access Token'
  }

  $mfajson = ($mfa.content | ConvertFrom-Json).value
  $DefaultMFA = $mfajson.defaultMfaMethod

  $countMFAMethods = ($mfajson.methodsRegistered).count
  if ($countMFAMethods -gt 1) {
    $MethodsRegist = $mfajson.methodsRegistered
    function MethodsWords ($i, $f, $p) {
      $start = $i
      while ($start -le $f) {
        $Words = $MethodsRegist[$start]
        $Letters = $MethodsRegist[$start].Length
        $new_words = $Words.Insert($Letters, ' | ')
        $set_of_words += $new_words
        $start += $p
        
      }
      return $set_of_words
    }

    $initiation = 0
    $end = $countMFAMethods - 1
    $go = 1
  
    $MethodsMFA = MethodsWords -i $initiation -f $end -p $go
  }
  else {
    $MethodsMFA = $mfajson.methodsRegistered 
  }
 

  $Smsjson = ($SMS.content | ConvertFrom-Json).value
  $Phone = $Smsjson.phoneNumber
  if ($Smsjson.phoneNumber -ne $null) {
    $MFASMS = $true
  }
  else { $MFASMS = $false }

  if (($DefaultMFA -eq $null) -and ($MethodsMFA -eq $null) ) {
    if ($MFASMS -eq $true) {
      $DefaultMFA = 'OneWaySMS'
      $MethodsMFA = 'OneWaySMS'
    }
  }

  if (($DefaultMFA -eq 'none') -and ($MethodsMFA -eq $null) -and ($MFASMS -eq $false) ) {
    $DefaultMFA = ''
  }
  
  $Userjson = ($User.content | ConvertFrom-Json).value
  $SignInName = $Userjson.userPrincipalName
  $displayName = $Userjson.displayName
  $DateCreate = $Userjson.createdDateTime
  $BlockCredential = $Userjson.accountEnabled
  $DN = $Userjson.onPremisesDistinguishedName  

  $Singjson = ($Sing.content | ConvertFrom-Json).value
  $Lestlogin = $Singjson.signInActivity.lastSignInDateTime
  
  $licensejson = ($license.content | ConvertFrom-Json).value
  If ($licensejson.skuId -ne $null) {
    $licenseId = $licensejson.skuId
    foreach ($licenseIds in $licenseId) {
      $Popline = ' | ' 
      $LicenseName = ($data | Where-Object GUID -EQ $licenseIds).Product_Display_Name | Get-Unique
      $licenseNames = $LicenseName + $Popline 

      $LicenseAll = [LicenseAll]::new()
      $LicenseAll.LicenseNameAll = $licenseNames
      $LicenseAllList.add($LicenseAll)
    }
  }



  $rolejson = ($role.content | ConvertFrom-Json).value
  $AADRoleName = $rolejson.displayName

  $SecuredPassword = ConvertTo-SecureString  $ClientSecret -AsPlainText -Force
  $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $ClientID, $SecuredPassword
  Connect-AzAccount -Credential $Credential -ServicePrincipal -TenantId $tenantid -WarningAction SilentlyContinue -ErrorAction Break | Out-Null

  $UPNRbac = $upn.replace('%23', '#')
  $RoleName = (Get-AzRoleAssignment -SignInName $UPNRbac  -WarningAction SilentlyContinue).RoleDefinitionName
  $RoleScope = (Get-AzRoleAssignment -SignInName $UPNRbac -WarningAction SilentlyContinue).Scope

  $ReportsUsers = [ReportsUsers]::new()
  $ReportsUsers.name = $displayName
  $ReportsUsers.email = $SignInName
  $ReportsUsers.MFADefault = $DefaultMFA
  $ReportsUsers.MFAMethods = $MethodsMFA 
  $ReportsUsers.MFASmsEnabled = $MFASMS 
  $ReportsUsers.MFANumber = $Phone 
  $ReportsUsers.license = $LicenseAllList.LicenseNameAll
  $ReportsUsers.RoleADAssignedUser = $AADRoleName 
  $ReportsUsers.RoleRbacName = $RoleName
  $ReportsUsers.RolesRbacScope = $RoleScope 
  $ReportsUsers.DN = $DN
  $ReportsUsers.AccoutCreate = $DateCreate
  $ReportsUsers.UserLestlogin = $Lestlogin
  $ReportsUsers.AccountEnabled = $BlockCredential
  $ReportsUsersList.add($ReportsUsers)

  return $ReportsUsersList
}



<#
 	.SYNOPSIS
      #################################################################################################################
      #                              Created by: Diogo De Santana Jacome                                              #
      #                              Co-creator: Luan Victor Cordeiro Levandoski                                      #
      #                              Modified by: Diogo De Santana Jacome                                             #
      #                                                                                                               #
      #                                                                                                               #
      #                                          Version: 1.0                                                         #
      #                                                                                                               #
      #                                                                                                               #
      #################################################################################################################     
      Get-AzGraphUser is an advanced function that can be used to verify all users, MFA, MS 365 license, Azure AD role, last login, user lock.
    
    .DESCRIPTION
      Get-AzGraphUser is an advanced function that can be used to verify all users, MFA, MS 365 license, Azure AD role, last login, user lock.

      You need a Service Principal that can access the graph API. API Permissions:
      AuditLog.Read.All
      Directory.Read.All
      Group.Read.All
      User.Read.All
      UserAuthenticationMethod.Read.All


      You need to have role Reader permission on Azure subscription and in Azure AD

      This function will download a CSV spreadsheet about the Microsoft Upgraded license
      Licensing-service-plan-reference: https://docs.microsoft.com/En-us/azure/active-directory/enterprise-users/licensing-service-plan-reference



    
    .EXAMPLE
      C:\PS> Get-AzGraphUser -upn test@contoso.onmicrosoft.com -tenantdomain contoso.onmicrosoft.com -ClientID 00000000-0000-0000-0000-00000000 -ClientSecret 0000zzzz0000zzzz0000zzzz
				
    .EXAMPLE
      C:\PS> Get-AzGraphUser -upn test@contoso.onmicrosoft.com -tenantdomain contoso.onmicrosoft.com -ClientID 00000000-0000-0000-0000-00000000 -ClientSecret 0000zzzz0000zzzz0000zzzz | export-csv report-security.csv
    
    .EXAMPLE
      C:\PS> $Users_Ids_Dev = (Get-AzADGroupMember -GroupDisplayName GP-Dev).id
      C:\PS> $Rbac_GP = Get-AzADGroupRBAC -Group GP-Dev
      C:\PS> Foreach ( $Users in $Users_Ids_Dev){
             $upn = (Get-AzADUser -ObjectId $Users).UserPrincipalName
             $Users_Graph_All Get-AzGraphUser -upn $upn -tenantdomain contoso.onmicrosoft.com -ClientID 00000000-0000-0000-0000-00000000 -ClientSecret 0000zzzz0000zzzz0000zzzz}
      C:\PS> $ListAll = ($Rbac_GP | Merge-Object $Users_Graph_All -On SignInName)
      C:\PS> $ListAll | export-csv Security-GP-Dev.csv


    .EXAMPLE
      C:\PS> $User_Ext = (Get-AzADUser |  Where-Object UserPrincipalName  -Like '*#EXT#@*').UserPrincipalName
      C:\PS> $User_Ext_ALL = $User_Ext.replace('#', '%23')
      C:\PS> Foreach ( $Users in $User_Ext_ALL){
             Get-AzGraphUser -upn $Users -tenantdomain contoso.onmicrosoft.com -ClientID 00000000-0000-0000-0000-00000000 -ClientSecret 0000zzzz0000zzzz0000zzzz}

		.LINK 
      https://github.com/Didjacome

	
        
#>
function Get-AzGraphUser {
  param (
    [Parameter(Mandatory)]
    [string]$upn,
    [Parameter(Mandatory)]
    [String]$tenantdomain,
    [Parameter(Mandatory)]
    [string]$ClientSecret,
    [Parameter(Mandatory)]
    [string]$ClientID
  )
  
  [string]$select = 'select'
  [string]$filter = 'filter'
  [string]$cifrao = '$'
  [string]$cf = $cifrao + $filter
  [string]$cs = $cifrao + $select
    
  $Uri_MS_License = 'https://download.microsoft.com/download/e/3/e/e3e9faf2-f28b-490a-9ada-c6089a1fc5b0/Product%20names%20and%20service%20plan%20identifiers%20for%20licensing.csv'
  $File_CSV_License = 'license.csv'
  if ((Test-Path $File_CSV_License) -eq $false) {
    Invoke-WebRequest -Uri $Uri_MS_License -OutFile $File_CSV_License
    $data = Import-Csv $File_CSV_License
  }
  else {
    $data = Import-Csv $File_CSV_License
  }


  class ReportsUsers {
    [string]$name
    [string]$SignInName
    [string]$MFADefault
    [string]$MFAMethods
    [string]$MFASmsEnabled
    [string]$MFANumber
    [string]$license
    [string]$RoleADAssignedUser
    [string]$DN
    [string]$AccoutCreate
    [string]$UserLestlogin
    [string]$AccountEnabled
  }
    
  $ReportsUsersList = New-Object Collections.Generic.List[ReportsUsers]
  
  class LicenseAll {
    [string]$LicenseNameAll
  }
  
  $LicenseAllList = New-Object Collections.Generic.List[LicenseAll]

  $loginURL = 'https://login.microsoftonline.com'
  $resource = 'https://graph.microsoft.com'           # Microsoft Graph API resource URI

  $body = @{grant_type = 'client_credentials'; resource = $resource; client_id = $ClientID; client_secret = $ClientSecret }
  $oauth = Invoke-RestMethod -Method Post -Uri $loginURL/$tenantdomain/oauth2/token?api-version=1.0 -Body $body
  if ($oauth.access_token -ne $null) {
    $headerParams = @{'Authorization' = "$($oauth.token_type) $($oauth.access_token)" }

    $MFA_url = "https://graph.microsoft.com/beta/reports/authenticationMethods/userRegistrationDetails?$cf=userPrincipalName eq '$upn'"
    $mfa = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $MFA_url)

    $MFASMS_URL = "https://graph.microsoft.com/beta/users/$upn/authentication/phoneMethods"
    $SMS = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $MFASMS_url)


    $User_url = "https://graph.microsoft.com/beta/users?$cf=userPrincipalName eq '$upn'" 
    $User = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $User_url)

    $Sing_url = "https://graph.microsoft.com/beta/users?$cf=userPrincipalName eq '$upn'&$cs=signInActivity" 
    $Sing = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $Sing_url)


    $license_url = "https://graph.microsoft.com/v1.0/users/$upn/licenseDetails"
    $license = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $license_url)

    $role_url = "https://graph.microsoft.com/beta/users/$upn/transitiveMemberOf/microsoft.graph.directoryRole?$cs=displayName"
    $role = Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $role_url  -SkipHttpErrorCheck -SkipHeaderValidation

  }
  else {
    Write-Host 'ERROR: No Access Token'
  }

  $mfajson = ($mfa.content | ConvertFrom-Json).value
  $DefaultMFA = $mfajson.defaultMfaMethod

  $countMFAMethods = ($mfajson.methodsRegistered).count
  if ($countMFAMethods -gt 1) {
    $MethodsRegist = $mfajson.methodsRegistered
    function MethodsWords ($i, $f, $p) {
      $start = $i
      while ($start -le $f) {
        $Words = $MethodsRegist[$start]
        $Letters = $MethodsRegist[$start].Length
        $new_words = $Words.Insert($Letters, ' | ')
        $set_of_words += $new_words
        $start += $p
        
      }
      return $set_of_words
    }

    $initiation = 0
    $end = $countMFAMethods - 1
    $go = 1
  
    $MethodsMFA = MethodsWords -i $initiation -f $end -p $go
  }
  else {
    $MethodsMFA = $mfajson.methodsRegistered 
  }

  $Smsjson = ($SMS.content | ConvertFrom-Json).value
  $Phone = $Smsjson.phoneNumber
  if ($Smsjson.phoneNumber -ne $null) {
    $MFASMS = $true
  }
  else { $MFASMS = $false }

  if (($DefaultMFA -eq $null) -and ($MethodsMFA -eq $null) ) {
    if ($MFASMS -eq $true) {
      $DefaultMFA = 'OneWaySMS'
      $MethodsMFA = 'OneWaySMS'
    }
  }

  if (($DefaultMFA -eq 'none') -and ($MethodsMFA -eq $null) -and ($MFASMS -eq $false) ) {
    $DefaultMFA = ''
  }
  
  $Userjson = ($User.content | ConvertFrom-Json).value
  $displayName = $Userjson.displayName
  $SignName = $Userjson.mail 
  $SignNameValidate = $SignName.Replace('#EXT#@sotreqcloud.onmicrosoft.com', '').Replace('_', '@')
  $DateCreate = $Userjson.createdDateTime
  $BlockCredential = $Userjson.accountEnabled
  $DN = $Userjson.onPremisesDistinguishedName  

  $Singjson = ($Sing.content | ConvertFrom-Json).value
  $Lestlogin = $Singjson.signInActivity.lastSignInDateTime
  
  $licensejson = ($license.content | ConvertFrom-Json).value
  If ($licensejson.skuId -ne $null) {
    $licenseId = $licensejson.skuId
    foreach ($licenseIds in $licenseId) {
      $Popline = ' | ' 
      $LicenseName = ($data | Where-Object GUID -EQ $licenseIds).Product_Display_Name | Get-Unique
      $licenseNames = $LicenseName + $Popline 

      $LicenseAll = [LicenseAll]::new()
      $LicenseAll.LicenseNameAll = $licenseNames
      $LicenseAllList.add($LicenseAll)
    }
  }

  $rolejson = ($role.content | ConvertFrom-Json).value
  $AADRoleName = $rolejson.displayName



  $ReportsUsers = [ReportsUsers]::new()
  $ReportsUsers.name = $displayName
  $ReportsUsers.SignInName = $SignNameValidate
  $ReportsUsers.MFADefault = $DefaultMFA
  $ReportsUsers.MFAMethods = $MethodsMFA 
  $ReportsUsers.MFASmsEnabled = $MFASMS 
  $ReportsUsers.MFANumber = $Phone 
  $ReportsUsers.license = $LicenseAllList.LicenseNameAll
  $ReportsUsers.RoleADAssignedUser = $AADRoleName 
  $ReportsUsers.DN = $DN
  $ReportsUsers.AccoutCreate = $DateCreate
  $ReportsUsers.UserLestlogin = $Lestlogin
  $ReportsUsers.AccountEnabled = $BlockCredential
  $ReportsUsersList.add($ReportsUsers)

  return $ReportsUsersList
}


<#
 	.SYNOPSIS
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
     New-AzSnapshotDiskOs is an advanced function that can be used to perform manager disk snapshots of Virtual Machine operating systems in Azure.
 
    .DESCRIPTION
     New-AzSnapshotDiskOs is an advanced function that can be used to perform manager disk snapshots of Virtual Machine operating systems in Azure.
     You need to have role Contibuitor in Subscription Azure
    
  
    .EXAMPLE
     C:\PS> New-AzSnapshotDiskOs -VmName VM-SQL-01 
     
    .EXAMPLE
     C:\PS> New-AzSnapshotDiskOs -VmName VM-SQL-01 -SnapshotName Snap-VM-SQL-OS -ResourceGroupName RG-Snapshots
   
    .EXAMPLE
     C:\PS> New-AzSnapshotDiskOs -VmName VM-SQL-01 -SnapshotName Snap-VM-SQL-OS -ResourceGroupName RG-Snapshots  -Tag @{Issue="xxxxxx";env="prd"}

    .EXAMPLE
     C:\PS> New-AzSnapshotDiskOs -ComputerName SQLSERVER  -SnapshotName Snap-VM-SQL-OS -ResourceGroupName RG-Snapshots
 
    .EXAMPLE
     C:\PS> $VM = (import-csv VirtualMachines.csv).Name
     C:\PS> Foreach ($VMS in $VM) {New-AzSnapshotDiskOs -VmName $VMS -Tag @{Issue="xxxxx";env="prd"}}

    .LINK 
     https://github.com/Didjacome


     
#>
function New-AzSnapshotDiskOs {
  [CmdletBinding(DefaultParameterSetName = 'VmName')]
  param (
    [Parameter(Mandatory, ParameterSetName = 'VmName')]
    [System.String]
    $VmName,
    [Parameter(Position = 0,
      Mandatory, ValueFromPipelineByPropertyName,
      ValueFromPipeline, ParameterSetName = 'ComputerName')]
    [System.String]
    $ComputerName,
    [string]$SnapshotName,
    [string]$ResourceGroupName,
    [Hashtable]$Tag


  )

  process {

    Write-Verbose "ParameterSetName is '$($PSCmdlet.ParameterSetName)'"

    if ($PSCmdlet.ParameterSetName -eq 'VmName') {
      $Vms = Get-AzVM | Where-Object Name -EQ $VmName
     
      if ($SnapshotName -eq '') {
        $Name = $Vms.Name
        $SnapshotName = $Name + '-OS'
        if ((Get-AzSnapshot -Name $SnapshotName).ProvisioningState -eq 'Succeeded') {
          $IdDisk = $Vms.StorageProfile.OsDisk.ManagedDisk.id
          $countNames = (Search-AzGraph -Query "Resources| where type == 'microsoft.compute/snapshots'  | where properties.provisioningState == 'Succeeded' and  properties.creationData.sourceResourceId == '$IdDisk'| project name").Count
          $nameSnaps = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/snapshots'  | where name == '$SnapshotName' and  properties.provisioningState == 'Succeeded'").name
          $SnapshotName = $nameSnaps + '-' + $countNames
        }
      }

      if ($ResourceGroupName -eq '') {
        $ResourceGroupName = $vms.ResourceGroupName
      }

      $Location = $Vms.Location      
      $OsDiskId = $Vms.StorageProfile.OsDisk.ManagedDisk.id


      if ($Tag -eq $null) {
        $SnapshotConfig = New-AzSnapshotConfig -SourceUri $OsDiskId -Location $Location -CreateOption copy
        New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotName -ResourceGroupName $ResourceGroupName
      }

      if ($Tag -ne $null) {
        $SnapshotConfig = New-AzSnapshotConfig -SourceUri $OsDiskId -Location $Location -CreateOption copy -Tag $Tag
        New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotName -ResourceGroupName $ResourceGroupName
      }
    }

    if ($PSCmdlet.ParameterSetName -eq 'ComputerName') {
      $CheckVmId_OsProfile = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/virtualmachines' | where properties.osProfile.computerName  == '$ComputerName'").id
      $CheckVmId_InstanceView = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/virtualmachines' | where properties.extended.instanceView.computerName   == '$ComputerName'").id

      If ($CheckVmId_OsProfile -eq $null) {
        if ($CheckVmId_InstanceView -eq $null) {
          Write-Error 'The computername does not exist, check that the name is correct. Case sensitive. If the problem persists utlize VMname with flag -VmName.';
          exit 1;
        }
        else {
          $Vms = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/virtualmachines' | where properties.extended.instanceView.computerName   == '$ComputerName'")
        }    
      }
      else {
        $Vms = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/virtualmachines' | where properties.osProfile.computerName  == '$ComputerName'")
      }
      
     
      if ($SnapshotName -eq '') {
        $Name = $Vms.Name
        $SnapshotName = $Name + '-OS'
        if ((Search-AzGraph -Query "Resources | where type == 'microsoft.compute/snapshots'  | where name == '$SnapshotName' and  properties.provisioningState == 'Succeeded'").properties.provisioningState -eq 'Succeeded') {
          $IdDisk = $vms.properties.storageProfile.osDisk.managedDisk.id
          $countNames = (Search-AzGraph -Query "Resources| where type == 'microsoft.compute/snapshots'  | where properties.provisioningState == 'Succeeded' and  properties.creationData.sourceResourceId == '$IdDisk'| project name").Count
          $nameSnaps = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/snapshots'  | where name == '$SnapshotName' and  properties.provisioningState == 'Succeeded'").name
          $SnapshotName = $nameSnaps + '-' + $countNames
        }
      }

      if ($ResourceGroupName -eq '') {
        $ResourceGroupName = $vms.ResourceGroup
      }

      $Location = $vms.Location      
      $OsDiskId = $vms.properties.storageProfile.osDisk.managedDisk.id

      if ($Tag -eq $null) {
        $SnapshotConfig = New-AzSnapshotConfig -SourceUri $OsDiskId -Location $Location -CreateOption copy
        New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotName -ResourceGroupName $ResourceGroupName
      }

      if ($Tag -ne $null) {
        $SnapshotConfig = New-AzSnapshotConfig -SourceUri $OsDiskId -Location $Location -CreateOption copy -Tag $Tag
        New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotName -ResourceGroupName $ResourceGroupName
      }
    }
  }
}
  


<#
  .SYNOPSIS
     #################################################################################################################
     #                              Created by: Diogo De Santana Jacome                                              #
     #                                                                                                               #
     #                              Modified by: Diogo De Santana Jacome                                             #
     #                                                                                                               #
     #                                                                                                               #
     #                                          version: 1.0                                                         #
     #                                                                                                               #
     #                                                                                                               #
     #################################################################################################################   
     New-AzSnapshotDiskAll is an advanced function that can be used to perform snapshots of all virtual machine manager disks in Azure.
 
   .DESCRIPTION
     New-AzSnapshotDiskAll is an advanced function that can be used to perform snapshots of all virtual machine manager disks in Azure.
     You need to have role Contibuitor in Subscription Azure

     Important:
     Not recommended for Azure shared disks



 
    .EXAMPLE
     C:\PS> New-AzSnapshotDiskAll -VmName VM-SQL-01 
     
    .EXAMPLE
     C:\PS> New-AzSnapshotDiskAll -VmName VM-SQL-01 -SnapshotName Snap -ResourceGroupName RG-Snapshots
   
    .EXAMPLE
     C:\PS> New-AzSnapshotDiskAll -VmName VM-SQL-01 -SnapshotName Snap -ResourceGroupName RG-Snapshots  -Tag @{Issue="xxxxxx";env="prd"}

    .EXAMPLE
     C:\PS> New-AzSnapshotDiskAll -ComputerName SQLSERVER  -SnapshotName Snap -ResourceGroupName RG-Snapshots
 
    .EXAMPLE
     C:\PS> $VM = (import-csv VirtualMachines.csv).Name
     C:\PS> Foreach ($VMS in $VM) {New-AzSnapshotDiskAll -VmName $VMS -Tag @{Issue="xxxxx";env="prd"}}

    .LINK 
     https://github.com/Didjacome


     
#>
function  New-AzSnapshotDiskAll {
  [CmdletBinding(DefaultParameterSetName = 'VmName')]
  param (
    [Parameter(Mandatory, ParameterSetName = 'VmName')]
    [System.String]
    $VmName,
    [Parameter(Position = 0,
      Mandatory, ValueFromPipelineByPropertyName,
      ValueFromPipeline, ParameterSetName = 'ComputerName')]
    [System.String]
    $ComputerName,
    [string]$SnapshotName,
    [string]$ResourceGroupName,
    [Hashtable]$Tag
  )

  process {

    Write-Verbose "ParameterSetName is '$($PSCmdlet.ParameterSetName)'"
    if ($PSCmdlet.ParameterSetName -eq 'VmName') {
      $Vms = Get-AzVM | Where-Object Name -EQ $VmName
      $IdVms = $Vms.id
      $DiskAll = Get-AzDisk | Where-Object ManagedBy -EQ $IdVms | Select-Object Name, id, OsType
      $Location = $Vms.Location 

      if ($SnapshotName -eq '') {
        $VmName = $Vms.Name
        $CountDiskDatas = ($diskall | Where-Object OsType -EQ $null).count
        class disknames {
          [string]$name
        }
        
        $disknamesAllList = New-Object Collections.Generic.List[disknames]

        function DiskNamesSum ($i, $f, $p) {
          $start = $i
          while ($start -le $f) {
            $NameSnapshot = $VmName + '-Data' + '-' + $start
            $disknames = [disknames]::new()
            $disknames.name = $NameSnapshot 
            $disknamesAllList.add($disknames)
            $start += $p
          }      
          return $disknamesAllList
        }

        $initiation = 0 
        $go = 1
        $end = $CountDiskDatas - 1

        DiskNamesSum -i $initiation -f $end -p $go
       
        $SnapshotNameDisk = $disknamesAllList.name

        $DataDiskAllId = ($diskall | Where-Object OsType -EQ $null).id

        if ($ResourceGroupName -eq '') {
          $ResourceGroupName = $vms.ResourceGroupName
        }
        
        if ($CountDiskDatas -ne 1) {
          if ($tag -eq $null) {
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId[$start] -Location $Location -CreateOption copy
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk[$start]  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -VmName $VmName -ResourceGroupName $ResourceGroupName
          }
        
          if ($Tag -ne $null) {
            function SetSnapNameAndDiskIdtag ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId[$start] -Location $Location -CreateOption copy -Tag $Tag
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk[$start]  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskIdtag -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -VmName $VmName -Tag $Tag -ResourceGroupName $ResourceGroupName

          }
        }

        if ($CountDiskDatas -eq 1) {
          if ($tag -eq $null) {
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId -Location $Location -CreateOption copy
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -VmName $VmName -ResourceGroupName $ResourceGroupName
          }
        
          if ($Tag -ne $null) {
            function SetSnapNameAndDiskIdtag ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId -Location $Location -CreateOption copy -Tag $Tag
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskIdtag -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -VmName $VmName -Tag $Tag -ResourceGroupName $ResourceGroupName

          }

        }
      }

    

      if ($SnapshotName -ne '') {
        $CountDiskDatas = ($diskall | Where-Object OsType -EQ $null).count
        
        class NamesDisk {
          [string]$name
        }
        
        $NamesDiskAllList = New-Object Collections.Generic.List[namesDisk]

        function DiskNamesSum ($i, $f, $p) {
          $start = $i
          while ($start -le $f) {
            $NameSnapshot = $SnapshotName + '-Data' + '-' + $start
            $NamesDisk = [NamesDisk]::new()
            $NamesDisk.name = $NameSnapshot 
            $NamesDiskAllList.add($NamesDisk)
            $start += $p
          }      
          return $NamesDiskAllList
        }

        $initiation = 0 
        $go = 1
        $end = $CountDiskDatas - 1

        DiskNamesSum -i $initiation -f $end -p $go
       
        $SnapshotNameDisk = $NamesDiskAllList.name

        $DataDiskAllId = ($diskall | Where-Object OsType -EQ $null).id

        if ($ResourceGroupName -eq '') {
          $ResourceGroupName = $vms.ResourceGroupName
        }


        If ($CountDiskDatas -ne 1) {
          if ($tag -eq $null) {
          
        
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId[$start] -Location $Location -CreateOption copy
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk[$start]  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -VmName $VmName -ResourceGroupName $ResourceGroupName
          }
          if ($tag -ne $null) {
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId[$start] -Location $Location -CreateOption copy -Tag $Tag
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk[$start]  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -VmName $VmName -Tag $Tag -ResourceGroupName $ResourceGroupName
          }
        }  


        If ($CountDiskDatas -eq 1) {
          if ($tag -eq $null) {
          
        
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId -Location $Location -CreateOption copy
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -VmName $VmName -ResourceGroupName $ResourceGroupName
          }
          if ($tag -ne $null) {
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId -Location $Location -CreateOption copy -Tag $Tag
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -VmName $VmName -Tag $Tag -ResourceGroupName $ResourceGroupName
          }
        }  
      }
    }


    if ($PSCmdlet.ParameterSetName -eq 'ComputerName') {

      $CheckVmId_OsProfile = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/virtualmachines' | where properties.osProfile.computerName  == '$ComputerName'").id
      $CheckVmId_InstanceView = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/virtualmachines' | where properties.extended.instanceView.computerName   == '$ComputerName'").id

      If ($CheckVmId_OsProfile -eq $null) {
        if ($CheckVmId_InstanceView -eq $null) {
          Write-Error 'The computername does not exist, check that the name is correct. Case sensitive. If the problem persists utlize VMname with flag -VmName.';
          exit 1;
        }
        else {
          $Vms = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/virtualmachines' | where properties.extended.instanceView.computerName   == '$ComputerName'")
        }    
      }
      else {
        $Vms = (Search-AzGraph -Query "Resources | where type == 'microsoft.compute/virtualmachines' | where properties.osProfile.computerName  == '$ComputerName'")
      }

      $IdVms = $Vms.id
      $DiskAll = Get-AzDisk | Where-Object ManagedBy -EQ $IdVms | Select-Object Name, id, OsType
      $Location = $Vms.Location 




      if ($SnapshotName -eq '') {
        $VmName = $Vms.Name
        $CountDiskDatas = ($diskall | Where-Object OsType -EQ $null).count
        class Computernamesdisk {
          [string]$name
        }
        
        $Computernamesdisklist = New-Object Collections.Generic.List[Computernamesdisk]

        function DiskNamesSum ($i, $f, $p) {
          $start = $i
          while ($start -le $f) {
            $NameSnapshot = $VmName + '-Data' + '-' + $start
            $Computernamesdisk = [Computernamesdisk]::new()
            $Computernamesdisk.name = $NameSnapshot 
            $Computernamesdisklist.add($Computernamesdisk)
            $start += $p
          }      
          return $Computernamesdisklist
        }

        $initiation = 0 
        $go = 1
        $end = $CountDiskDatas - 1

        DiskNamesSum -i $initiation -f $end -p $go
       
        $SnapshotNameDisk = $Computernamesdisklist.name

        $DataDiskAllId = ($diskall | Where-Object OsType -EQ $null).id

        if ($ResourceGroupName -eq '') {
          $ResourceGroupName = $vms.ResourceGroup
        }


        if ( $CountDiskDatas -ne 1) {
          if ($tag -eq $null) {
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId[$start] -Location $Location -CreateOption copy
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk[$start]  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -ComputerName $ComputerName -ResourceGroupName $ResourceGroupName
          }
        
          if ($Tag -ne $null) {
            function SetSnapNameAndDiskIdtag ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId[$start] -Location $Location -CreateOption copy -Tag $Tag
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk[$start]  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskIdtag -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -ComputerName  $ComputerName -Tag $Tag -ResourceGroupName $ResourceGroupName

          }
        }




        if ( $CountDiskDatas -eq 1) {
          if ($tag -eq $null) {
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId -Location $Location -CreateOption copy
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -ComputerName $ComputerName -ResourceGroupName $ResourceGroupName
          }
        
          if ($Tag -ne $null) {
            function SetSnapNameAndDiskIdtag ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId -Location $Location -CreateOption copy -Tag $Tag
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskIdtag -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -ComputerName  $ComputerName -Tag $Tag -ResourceGroupName $ResourceGroupName

          }
        }
      }





      if ($SnapshotName -ne '') {
        $VmName = $Vms.Name
        $CountDiskDatas = ($diskall | Where-Object OsType -EQ $null).count
        
        class ComputerNameDiskNames {
          [string]$name
        }
        
        $ComputerNameDiskNamesAllList = New-Object Collections.Generic.List[ComputerNameDiskNames]

        function DiskNamesSum ($i, $f, $p) {
          $start = $i
          while ($start -le $f) {
            $NameSnapshot = $SnapshotName + '-Data' + '-' + $start
            $ComputerNameDiskNames = [ComputerNameDiskNames]::new()
            $ComputerNameDiskNames.name = $NameSnapshot 
            $ComputerNameDiskNamesAllList.add($ComputerNameDiskNames)
            $start += $p
          }      
          return $ComputerNameDiskNamesAllList
        }

        $initiation = 0 
        $go = 1
        $end = $CountDiskDatas - 1

        DiskNamesSum -i $initiation -f $end -p $go
       
        $SnapshotNameDisk = $ComputerNameDiskNamesAllList.name

        $DataDiskAllId = ($diskall | Where-Object OsType -EQ $null).id

        if ($ResourceGroupName -eq '') {
          $ResourceGroupName = $vms.ResourceGroup
        }




        if ($CountDiskDatas -ne 1) {
  
          if ($tag -eq $null) {
          
        
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId[$start] -Location $Location -CreateOption copy
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk[$start]  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -ComputerName $ComputerName -ResourceGroupName $ResourceGroupName
          }
          if ($tag -ne $null) {
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId[$start] -Location $Location -CreateOption copy -Tag $Tag
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk[$start]  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -ComputerName $ComputerName -Tag $Tag -ResourceGroupName $ResourceGroupName
          }
        
        }


        if ($CountDiskDatas -eq 1) {
  
          if ($tag -eq $null) {
          
        
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId -Location $Location -CreateOption copy
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -ComputerName $ComputerName -ResourceGroupName $ResourceGroupName
          }
          if ($tag -ne $null) {
            function SetSnapNameAndDiskId ($i, $f, $p) {
              $start = $i
              While ($start -le $f) {
                $SnapshotConfig = New-AzSnapshotConfig -SourceUri $DataDiskAllId -Location $Location -CreateOption copy -Tag $Tag
                New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotNameDisk  -ResourceGroupName $ResourceGroupName | Out-Null
                $start += $p
              }
            }
            $numberloop = $DataDiskAllId.count
            $initiation = 0 
            $go = 1
            $end = $numberloop - 1
            SetSnapNameAndDiskId -i $initiation -f $end -p $go
            New-AzSnapshotDiskOs -ComputerName $ComputerName -Tag $Tag -ResourceGroupName $ResourceGroupName
          }
        
        }

      }
    }

  }
}



<#
  .SYNOPSIS
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
   
 
    .DESCRIPTION
     New-SnapshotDisk is an advanced function that can be used to take snapshots of the virtual machine point manager disks in Azure.
     You need to have role Contibuitor in Subscription Azure

     Important:
     Not recommended for Azure shared disks

 
    .EXAMPLE
     C:\PS> New-AzSnapshotDisk -DiskName VM-SQL_OSDisk
     
    .EXAMPLE
     C:\PS> New-AzSnapshotDisk -DiskName VM-SQL_OSDisk -SnapshotName Snap -ResourceGroupName RG-Snapshots
   
    .EXAMPLE
     C:\PS> New-AzSnapshotDisk -DiskId xxxxxx-xxxx-xxxxx-xxxx -SnapshotName Snap -ResourceGroupName RG-Snapshots  -Tag @{Issue="xxxxxx";env="prd"}

    .LINK 
     https://github.com/Didjacome


     
#>
function New-AzSnapshotDisk {
  [CmdletBinding(DefaultParameterSetName = 'DiskName')]

  param (
    [Parameter(Mandatory, ParameterSetName = 'DiskName')]
    [string]$diskName,
    [Parameter(Position = 0,
      Mandatory, ValueFromPipelineByPropertyName,
      ValueFromPipeline, ParameterSetName = 'diskId')] 
    [string]$diskId,   
    [string]$SnapshotName,
    [string]$ResourceGroupName,
    [Hashtable]$Tag
  )

  process {
    Write-Verbose "ParameterSetName is '$($PSCmdlet.ParameterSetName)'"
    if ($PSCmdlet.ParameterSetName -eq 'DiskName') {
      $disk = Get-AzDisk -name $diskName
      $id = $disk.id
      $Location = $disk.location

      if ($ResourceGroupName -eq '') {
        $ResourceGroupName = $disk.ResourceGroupName
      }

      if ($SnapshotName -eq '') {
        $SnapshotName = $diskName + 'Snap-01'
      }

      if ($Tag -eq $null) {
        $SnapshotConfig = New-AzSnapshotConfig -SourceUri $id -Location $Location -CreateOption copy
        New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotName  -ResourceGroupName $ResourceGroupName | Out-Null
      }

      if ($Tag -ne $null) {
        $SnapshotConfig = New-AzSnapshotConfig -SourceUri $id -Location $Location -CreateOption copy -Tag $Tag
        New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotName  -ResourceGroupName $ResourceGroupName | Out-Null
      } 
    }

    if ($PSCmdlet.ParameterSetName -eq 'diskId') {
      $disk = (Get-AzDisk  | Where-Object Id -EQ $diskId)
      $id = $disk.id
      $name = $disk.name
      $Location = $disk.location

      if ($ResourceGroupName -eq '') {
        $ResourceGroupName = $disk.ResourceGroupName
      }

      if ($SnapshotName -eq '') {
        $SnapshotName = $Name + 'Snap-01'
      }

      if ($Tag -eq $null) {
        $SnapshotConfig = New-AzSnapshotConfig -SourceUri $id -Location $Location -CreateOption copy
        New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotName  -ResourceGroupName $ResourceGroupName | Out-Null
      }

      if ($Tag -ne $null) {
        $SnapshotConfig = New-AzSnapshotConfig -SourceUri $id -Location $Location -CreateOption copy -Tag $Tag
        New-AzSnapshot -Snapshot $SnapshotConfig -SnapshotName $SnapshotName  -ResourceGroupName $ResourceGroupName | Out-Null
      } 
    }
  }
}

<#
  .SYNOPSIS
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
   
 
    .DESCRIPTION
     Get-AzVnetInvertory is an advanced function that can be used to generate a report of the current state of your vnets
     You must have the Reader role in Azure Subscription

     Important:
     If you have more than one Azure Subscription, connect to the management group to use the "Get-AzVnetInvertory -All" flag.

 
    .EXAMPLE
     C:\PS> Get-AzVnetInvertory
     
    .EXAMPLE
     C:\PS> Get-AzVnetInvertory -vnetName vnet-hub-us
   
    .EXAMPLE
     C:\PS> $vnets= (import-csv vnets.csv).Name
     C:\PS> Foreach ($vnet in $vnets) {Get-AzVnetInvertory -vnetName $vnet }

    .LINK 
     https://github.com/Didjacome


     
#>

function Get-AzVnetInvertory  {
  [CmdletBinding(DefaultParameterSetName = 'All')]

  param (
    # Parameter help description
    [Parameter(Mandatory = $false, ParameterSetName = 'vnet')]
    [System.String]
    $vnetName,

    [Parameter(Mandatory = $false, ParameterSetName = 'All')]
    [switch]
    $All
)

process {
    if ($PSCmdlet.ParameterSetName -eq 'All'){
        $vNets = Get-AzVirtualNetwork

        foreach ($vNet in $vNets) {
            $subnetList = @()
            foreach ($subnet in $vNet.Subnets) {
                $subnetList += "[ $($subnet.Name) | $($subnet.AddressPrefix -join ', ') ] "
            }
          
            $vnetPeeringList = @()
            foreach ($vnetPeering in $vNet.VirtualNetworkPeerings) {
                $remoteVNET =  $vnetPeering.RemoteVirtualNetwork
                $remoteVNETName = ($remoteVNET | foreach-Object {Split-Path $_.Id -leaf}) -join ', '
                $remoteVNETAddressSpace = $vnetPeering.RemoteVirtualNetworkAddressSpace.AddressPrefixes -join ', '
                $vnetPeeringList += "[ $($vnetPeering.Name) | $($vnetPeering.PeeringState) | $remoteVNETName | $remoteVNETAddressSpace ] "
            }
          
            [PSCustomObject]@{
                Name = $vNet.Name
                ResourceGroupName = $vNet.ResourceGroupName
                Location = $vNet.Location
                Id = $vNet.Id
                AddressSpace =  $vNet.AddressSpace.AddressPrefixes -join ', '
                Subnets = $subnetList -join ', '
                VnetPeerings = $vnetPeeringList -join ', '
                EnableDdosProtection = $vNet.EnableDdosProtection
            }
        }
      }
    if ($PSCmdlet.ParameterSetName -eq 'vnet'){

        $vNets = Get-AzVirtualNetwork -Name $vnetName

        foreach ($vNet in $vNets) {
            $subnetList = @()
            foreach ($subnet in $vNet.Subnets) {
                $subnetList += "[ $($subnet.Name) | $($subnet.AddressPrefix -join ', ') ] "
            }
          
            $vnetPeeringList = @()
            foreach ($vnetPeering in $vNet.VirtualNetworkPeerings) {
                $remoteVNET =  $vnetPeering.RemoteVirtualNetwork
                $remoteVNETName = ($remoteVNET | foreach-Object {Split-Path $_.Id -leaf}) -join ', '
                $remoteVNETAddressSpace = $vnetPeering.RemoteVirtualNetworkAddressSpace.AddressPrefixes -join ', '
                $vnetPeeringList += "[ $($vnetPeering.Name) | $($vnetPeering.PeeringState) | $remoteVNETName | $remoteVNETAddressSpace ] "
            }
          
            [PSCustomObject]@{
                Name = $vNet.Name
                ResourceGroupName = $vNet.ResourceGroupName
                Location = $vNet.Location
                Id = $vNet.Id
                AddressSpace =  $vNet.AddressSpace.AddressPrefixes -join ', '
                Subnets = $subnetList -join ', '
                VnetPeerings = $vnetPeeringList -join ', '
                EnableDdosProtection = $vNet.EnableDdosProtection
            }
        }
      }
  }
}



<#
  .SYNOPSIS
     #################################################################################################################
     #                              Created by: Diogo De Santana Jacome                                              #
     #                              Co-creator: Isaías Vaz Moreira                                                   #
     #                              Modified by: Diogo De Santana Jacome                                             #
     #                                                                                                               #
     #                                                                                                               #
     #                                          Version: 1.0                                                         #
     #                                                                                                               #
     #                                                                                                               #
     #################################################################################################################   
   
 
    .DESCRIPTION
    Get-AzValidateWebAppMigrate is an advanced function for verifying that Azure Web App and Azure Functions are in their source resource groups, thereby facilitating potential subscription migration. 
    Using logic to validate whether the "RG" is the same as the Azure Web Application and Azure Functions "RG" are the same as your Apps Plans.
    You need to have role Reader in Subscription Azure or equivalent access.

     Important:
     The "-Export" flag will create a file "AzureWebAPP-Migrate.xlsx" in the current directory.

 
    .EXAMPLE
     C:\PS> Get-AzValidateWebAppMigrate
     
    .EXAMPLE
     C:\PS> Get-AzValidateWebAppMigrate -AppName webApp-test
   
    .EXAMPLE
     C:\PS> Get-AzValidateWebAppMigrate -All -Export

    .LINK 
     https://github.com/Didjacome


     
#>

function Get-AzValidateWebAppMigrate {

  [CmdletBinding(DefaultParameterSetName = 'All')]
  param (
    [Parameter(Mandatory = $false)]
    [switch]
    $Export,

    [Parameter(Mandatory = $false, ParameterSetName = 'name')]
    [System.String]
    $AppName,

    [Parameter(Mandatory = $false, ParameterSetName = 'All')]
    [switch]
    $All
  )

  process {
    class App {
      [string]$WebAppName
      [string]$RGWebApp
      [string]$Kind
      [string]$CutomDNS
      [string]$LastModifiedTimeUtc
      [string]$State
      [string]$Vnet
      [string]$AppServicePlanName
      [string]$RGAppPlan
      [bool]$ChangeRG
      [string]$Move
    }

    $Applist = New-Object 'System.Collections.Generic.List[App]'

    if ($PSCmdlet.ParameterSetName -eq 'All') {
      $webapp = Get-AzWebApp

      foreach ($i in $webapp ) {
        $AppServicePlan = Get-AzResource -ResourceId $i.ServerFarmId

        $App = [App]::new()
        $App.WebAppName = $i.Name
        $App.RGWebApp = $i.ResourceGroup
        $app.Kind = $i.Kind
        $App.CutomDNS = $i.HostNames | Where-Object { $_ -notmatch 'azure' }
        $App.LastModifiedTimeUtc = $i.LastModifiedTimeUtc
        $App.Vnet = $i.VirtualNetworkSubnetId
        $app.State = $i.State
        $App.AppServicePlanName = $AppServicePlan.Name
        $App.RGAppPlan = $AppServicePlan.ResourceGroupName
        $app.ChangeRG = $AppServicePlan.ResourceGroupName -notmatch $i.ResourceGroup
        $App.Move = if ($app.ChangeRG -eq $true) { 'To migrate, you need to move the Web App ' + $i.Name + ' to the source RG ' + $AppServicePlan.ResourceGroupName + '.' }else { "For the migration, it's not necessary to move." }
        $Applist.add($App)
      }


      if ($Export -eq $true ) {
        $Applist | Export-Excel -Path "./AzureWebAPP-Migrate.xlsx" -WorksheetName 'Azure Web App' -AutoSize -TableStyle 'Light9' -FreezeTopRow -Append
      }
      return $Applist
    } 

    if ($PSCmdlet.ParameterSetName -eq 'name') {
      $webapp = Get-AzWebApp -Name $AppName

      foreach ($i in $webapp ) {
        $AppServicePlan = Get-AzResource -ResourceId $i.ServerFarmId

        $App = [App]::new()
        $App.WebAppName = $i.Name
        $App.RGWebApp = $i.ResourceGroup
        $app.Kind = $i.Kind
        $App.CutomDNS = $i.HostNames | Where-Object { $_ -notmatch 'azure' }
        $App.LastModifiedTimeUtc = $i.LastModifiedTimeUtc
        $App.Vnet  = $i.VirtualNetworkSubnetId
        $app.State = $i.State
        $App.AppServicePlanName = $AppServicePlan.Name
        $App.RGAppPlan = $AppServicePlan.ResourceGroupName
        $app.ChangeRG = $AppServicePlan.ResourceGroupName -notmatch $i.ResourceGroup
        $App.Move = if ($app.ChangeRG -eq $true) { 'To migrate, you need to move the Web App ' + $i.Name + ' to the source RG ' + $AppServicePlan.ResourceGroupName + '.' }else { "For the migration, it's not necessary to move." }
        $Applist.add($App)
      }

      if ($Export -eq $true ) {
        $Applist | Export-Excel -Path "./AzureWebAPP-Migrate.xlsx" -WorksheetName 'Azure Web App' -AutoSize -TableStyle 'Light9' -FreezeTopRow -Append
      }

      return $Applist
    }
  }
}