# GET-RBAC

# Summary
Export Rbac permissions at different levels in CSV

# Stage
Run the Role-RBAC.ps1 script

Connect-AzAccount 

.\Role-RBAC.ps1

output:

![image](https://user-images.githubusercontent.com/83463639/158035768-0b4dce52-bf0b-49ab-90e3-4e31ac00bd9c.png)


![image](https://user-images.githubusercontent.com/83463639/158035479-132067c2-5002-4aa7-b78a-003ff53baf99.png)


Import-Module .\AZ.RBAC.psm1

Get-Module 

output:

![image](https://user-images.githubusercontent.com/83463639/158035514-8cb7173b-0b75-4000-a22c-ad432de755f6.png)




Run the Get-AzADGroupRBAC module

<#
      
      .SYNOPSIS
      #################################################################################################################
      #                              Criador: Diogo De Santana Jacome                                                 #
      #                              Empresa:  Solo Network                                                           #
      #                              Modifcado por: Diogo De Santana Jacome                                           #
      #                                                                                                               #
      #                                                                                                               #
      #                                          Versão: 1.0                                                          #
      #                                                                                                               #
      #                                                                                                               #
      #################################################################################################################   
      
      GET-AzADGroupRBAC is an advanced function that can be used to check all users of groups that have RBAC permission
    
    .DESCRIPTION
      GET-AzADGroupRBAC is an advanced function that can be used to check all users of groups that have RBAC permission

      You need to be connected to Azure subscription 

      You need to have role Reader permission on Azure subscription and in Azure AD



    
    .EXAMPLE
      C:\PS> GET-AzADGroupRBAC -import .\AZAD_Groups.csv
				
    .EXAMPLE
      C:\PS> GET-AzADGroupRBAC -group GP-Ower
    
    .EXAMPLE
      C:\PS> GET-AzADGroupRBAC -import .\AZAD_Groups.csv | export-csv Export-Csv C:\Users\$env:USERNAME\Documents\GroupUserAll.csv
		.LINK 
      https://github.com/Didjacome/GET-RBAC

	
        
#>










