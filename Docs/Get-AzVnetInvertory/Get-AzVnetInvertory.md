# Cmdlet "Get-AzVnetInvertory"

# Summary
Perform the inventory of all vnets <br>
You can export the output to a general report in CSV

# Basic Usage
## Installation

```powershell
Install-Module -Name Az.Adm
```
## Validating the vnet
```powershell
Get-AzVnetInvertory -vnetName vnet-hub-us
```
<br>

pending...

<br>

# Stage

loading...

# Step on
loading...

output:

loading...




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
    
    .DESCRIPTION
      Get-AzVnetInvertory is an advanced function that can be used to generate a report of the current state of your vnets
      You must have the Reader role in Azure Subscription

      You need to be connected to Azure subscription 

      Important:
      If you have more than one Azure Subscription, connect to the management group to use the "Get-AzVnetInvertory -All" flag.




    
    .EXAMPLE
      C:\PS> Get-AzVnetInvertory -All
				
    .EXAMPLE
      C:\PS> Get-AzVnetInvertory -vnetName vnet-hub-us

    .EXAMPLE
      C:\PS> $vnets= (import-csv vnets.csv).Name
      C:\PS> Foreach ($vnet in $vnets) {Get-AzVnetInvertory -vnetName $vnet }
    
		.LINK 
      https://github.com/Didjacome