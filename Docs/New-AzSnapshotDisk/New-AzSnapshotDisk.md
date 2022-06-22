# Cmdlet "New-AzSnapshotDiskOS"

# Summary
This cmdlet can be used to take snapshots of manager disks. <br>


# Basic Usage
## Installation

```powershell
Install-Module -Name Az.Adm
```
## Snapshot vm Sql
```powershell
New-AzSnapshotDiskOS -diskName VM-SQL_OSdisk
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

 
    .EXAMPLE
     C:\PS> New-AzSnapshotDisk -DiskName VM-SQL_OSDisk
     
    .EXAMPLE
     C:\PS> New-AzSnapshotDisk -DiskName VM-SQL_OSDisk -SnapshotName Snap -ResourceGroupName RG-Snapshots
   
    .EXAMPLE
     C:\PS> New-AzSnapshotDisk -DiskId xxxxxx-xxxx-xxxxx-xxxx -SnapshotName Snap -ResourceGroupName RG-Snapshots  -Tag @{Issue="xxxxxx";env="prd"}

    .LINK 
     https://github.com/Didjacome
