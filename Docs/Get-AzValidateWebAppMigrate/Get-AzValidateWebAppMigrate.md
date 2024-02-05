# Cmdlet "Get-AzValidateWebAppMigrate"

# Summary
Get-AzValidateWebAppMigrate is an advanced function for verifying that Azure Web App and Azure Functions are in their source resource groups, thereby facilitating potential subscription migration. <br>
Using logic to validate whether the "RG" is the same as the Azure Web Application and Azure Functions "RG" are the same as your Apps Plans.

# Basic Usage
## Installation

```powershell
Install-Module -Name Az.Adm
```
## Validating all Azure web app
```powershell
Get-AzValidateWebAppMigrate
```
<br>

![image](https://github.com/Didjacome/Modules.Azure/assets/83463639/d74e8b61-530d-4b3e-ab3c-cbf00a02143b)


<br>

# Help cmdlet




      
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
