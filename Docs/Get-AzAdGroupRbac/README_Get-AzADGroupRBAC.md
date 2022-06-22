# Cmdlet "Get-AzADGroupRBAC"

# Summary
Check all users from groups that have RBAC permission <br>
You can export Rbac permissions at different levels in CSV

# Basic Usage
## Installation

```powershell
Install-Module -Name Az.Adm
```
## Validating the group
```powershell
Get-AzAdGroupRbac -Group Test
```
<br>

![image](https://user-images.githubusercontent.com/83463639/158490268-47d96c7e-2123-476f-b758-e17f1cdf968b.png)

<br>

# Stage

In the repository ![Assessment Rbac](https://github.com/Didjacome/Modules.Azure/tree/main/script/Assessment-Rbac)  you will see an example script.
<br>
With this script you can get this result.

# Step on
Connect in your subscription
```powershell
Connect-AzAccount 
```


Run the Role-RBAC.ps1 script

```powershell
. .\Role-RBAC.ps1
```

output:

![image](https://user-images.githubusercontent.com/83463639/158035768-0b4dce52-bf0b-49ab-90e3-4e31ac00bd9c.png)


![image](https://user-images.githubusercontent.com/83463639/158035479-132067c2-5002-4aa7-b78a-003ff53baf99.png)




# Help cmdlet




      
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
      Get-AzADGroupRBAC is an advanced function that can be used to check all users of groups that have RBAC permission
    
    .DESCRIPTION
      Get-AzADGroupRBAC is an advanced function that can be used to check all users of groups that have RBAC permission

      You need to be connected to Azure subscription 

      You need to have role Reader permission on Azure subscription and in Azure AD



    
    .EXAMPLE
      C:\PS> Get-AzADGroupRBAC -Import .\AZAD_Groups.csv
				
    .EXAMPLE
      C:\PS> Get-AzADGroupRBAC -Group GP-Ower

    .EXAMPLE
      C:\PS> Get-AzADGroupRBAC -Group xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    
    .EXAMPLE
      C:\PS> Get-AzADGroupRBAC -Import .\AZAD_Groups.csv |  Export-Csv C:\Users\$env:USERNAME\Documents\GroupUserAll.csv
		.LINK 
      https://github.com/Didjacome


	
        











