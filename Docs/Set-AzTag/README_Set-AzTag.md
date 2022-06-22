# Cmdlet "Set-AzTag"

# Summary
Configure tags on all resources in a resource group

# Basic Usage
## Installation

```powershell
Install-Module -Name Az.Adm
```
## Place Tags on all resources in a resource group
```powershell
Set-AzTag -RG RG-DEV-SCENTUS-001 -ImportCSV .\teste.csv
```
output:
![image](https://user-images.githubusercontent.com/83463639/158490832-891014fc-0ed1-4bc3-aa32-86bed80fc2d6.png)


<br><br><br>
For you to execute this function it is necessary to inform the Resource Group Name
<br> <br> <br>
Csv must have a TAG NAME column and a TAG VALUE column <br>
Example:

![image](https://user-images.githubusercontent.com/83463639/158466800-a954dacc-b634-494c-89e9-a25e8719eb51.png)

<br> <br> <br>




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



