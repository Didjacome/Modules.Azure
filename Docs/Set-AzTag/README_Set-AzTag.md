# Set-AzTag

# Summary
Configure tags on all resources in a resource group

# Stage


Import-Module .\Az.Adm.psm1

<br><br>

Get-Module 

output:

![image](https://user-images.githubusercontent.com/83463639/158466944-4d6f4967-26c5-491c-a0cc-eaa7467fd89a.png)


<br><br><br>
For you to execute this function it is necessary to inform the Resource Group Name
<br> <br> <br>
Csv must have a TAG NAME column and a TAG VALUE column <br>
Example:

![image](https://user-images.githubusercontent.com/83463639/158466800-a954dacc-b634-494c-89e9-a25e8719eb51.png)

<br> <br> <br>

Run the Set-AzTag function

<br><br>

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



