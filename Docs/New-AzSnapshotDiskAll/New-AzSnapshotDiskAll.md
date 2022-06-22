# Cmdlet "New-AzSnapshotDiskAll"

# Summary
This cmdlet can be used to take snapshots of all the disks in the virtual machine manager in Azure. <br>


# Basic Usage
## Installation

```powershell
Install-Module -Name Az.Adm
```
## Snapshot vm Sql
```powershell
New-AzSnapshotDiskAll -VmName VM-SQL-01 
```
<br>

![image](https://user-images.githubusercontent.com/83463639/158490268-47d96c7e-2123-476f-b758-e17f1cdf968b.png)

<br>

# Stage

In the repository ![Assessment User](https://github.com/Didjacome/Modules.Azure/tree/main/Snapshot-All-VM)  you will see an example script.
<br>
With this script you can get this result.

# Step on
Connect in your subscription
```powershell
Connect-AzAccount 
```


Run the SnapshotDiskAll.ps1 script

```powershell
. .\SnapshotDiskAll.ps1
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


	
        











