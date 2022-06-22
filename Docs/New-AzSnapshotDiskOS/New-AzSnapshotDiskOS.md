# Cmdlet "New-AzSnapshotDiskOS"

# Summary
This cmdlet can be used to take OS disk snapshots of virtual machines in Azure. <br>


# Basic Usage
## Installation

```powershell
Install-Module -Name Az.Adm
```
## Snapshot vm Sql
```powershell
New-AzSnapshotDiskOS -VmName VM-SQL-01 
```
<br>




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