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

function  Get-AzADGroupRBAC {

  [CmdletBinding(DefaultParameterSetName='group')]
  
  param(
     [Parameter(ParameterSetName='group')]
     [string]
     $group,
   
   
     [Parameter(Position=0,
     Mandatory,ValueFromPipelineByPropertyName,
     ValueFromPipeline,ParameterSetName='import')]
     [string]
     $Import
   )
 
   
     $Validar_Import = Test-Path $Import 
     $ValidarGP = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $group | Select-Object -ExpandProperty DisplayName 
  
 
   if ( $Validar_Import -eq $true){
 
     $var1 = Import-Csv c:\users\$env:username\Documents\Group_RBAC.csv | Select-Object -ExpandProperty DisplayName
   }
   elseif ( $ValidarGP -like $group ) {
     
     $var1 = $group
     
   }
   else {
     Write-Host "Group does not exist or Csv import error
 
     Please go to "https://github.com/Didjacome/GET-RBAC"" 
   }
 
     
      
 
  foreach ($var2 in $var1)
   {   
 
   $RoleGroup = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object  DisplayName -like $var2 | Select-Object -ExpandProperty RoleDefinitionName 
 
   $ScopeRBAC = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object  DisplayName -like $var2  | Select-Object -ExpandProperty Scope 
   
   $GroupAssignment = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object  DisplayName -like $var2  | Select-Object -ExpandProperty DisplayName
 
   $name = Get-AzADGroupMember -GroupDisplayName $var2  | Select-Object -ExpandProperty DisplayName 
 
   foreach ($ver in $name) { Get-AzADUser -DisplayName $ver | Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},@{n="RoleDefinitionName";e={"$RoleGroup"}},@{n="Scope";e={"$ScopeRBAC"}},@{n="associated group";e={"$GroupAssignment"}}}
 
   }
 }
 
 