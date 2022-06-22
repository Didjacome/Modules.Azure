# Cmdlet "Get-AzGraphUserRbac"

# Summary
Check users for security assessment, bringing up MFA information, MS 365 license, Azure AD role, Subscription Role ,last login, user lock. <br>


# Basic Usage
## Installation

```powershell
Install-Module -Name Az.Adm
```
## Validating the User
```powershell
Get-AzGraphUserRbac -upn test@contoso.onmicrosoft.com -tenantdomain contoso.onmicrosoft.com -ClientID 00000000-0000-0000-0000-00000000 -ClientSecret 0000zzzz0000zzzz0000zzzz -tenantid xxxxx-xxxxx-xxxxxx-xxxxx
```
<br>

![image](https://user-images.githubusercontent.com/83463639/158490268-47d96c7e-2123-476f-b758-e17f1cdf968b.png)

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

![image](https://user-images.githubusercontent.com/83463639/158035768-0b4dce52-bf0b-49ab-90e3-4e31ac00bd9c.png)


![image](https://user-images.githubusercontent.com/83463639/158035479-132067c2-5002-4aa7-b78a-003ff53baf99.png)




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


	
        











