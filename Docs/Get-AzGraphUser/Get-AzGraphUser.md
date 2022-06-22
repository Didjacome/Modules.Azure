# Cmdlet "Get-AzGraphUser"

# Summary
Check users for security assessment, bringing up MFA information, MS 365 license, Azure AD role, last login, user lock. <br>


# Basic Usage
## Installation

```powershell
Install-Module -Name Az.Adm
```
## Validating the User
```powershell
Get-AzGraphUser -upn test@contoso.onmicrosoft.com -tenantdomain contoso.onmicrosoft.com -ClientID 00000000-0000-0000-0000-00000000 -ClientSecret 0000zzzz0000zzzz0000zzzz
```
<br>

![image](https://user-images.githubusercontent.com/83463639/175081043-9613b8b0-45de-4e67-8761-7729811ca3a5.png)


<br>

# Stage

In the repository ![Assessment User](https://github.com/Didjacome/Modules.Azure/tree/main/scriptAssessment-SecurityUsers)  you will see an example script.
<br>
With this script you can get this result.

# Step on
Connect in your subscription
```powershell
Connect-AzAccount 
```


Run the AssessmentSecurity.ps1 script

```powershell
. .\AssessmentSecurity.ps1
```

output:

![image](https://user-images.githubusercontent.com/83463639/175078337-82f92e7c-e1b7-4ed9-a456-f0385923ea7b.png)




# Help cmdlet




      
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

	
        











