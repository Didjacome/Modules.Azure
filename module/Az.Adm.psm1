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
      C:\PS> Get-AzADGroupRBAC -Import .\AZAD_Groups.csv | export-csv Export-Csv C:\Users\$env:USERNAME\Documents\GroupUserAll.csv
		.LINK 
      https://github.com/Didjacome/GET-RBAC

	
        
#>

function  Get-AzADGroupRBAC {

  [CmdletBinding(DefaultParameterSetName = 'Group')]
  
  param(
    [Parameter(Mandatory, ParameterSetName = 'Group')]
    [string]
    $Group,
   
   
    [Parameter(Position = 0,
      Mandatory, ValueFromPipelineByPropertyName,
      ValueFromPipeline, ParameterSetName = 'import')]
    [string]
    $Import
  )
 
  process {
   
    
   
   
    Write-Verbose "ParameterSetName is '$($PSCmdlet.ParameterSetName)'"
    if ( $PSCmdlet.ParameterSetName -eq 'import' ) { 
      
      $Validar_Import = Test-Path $Import -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
      
      if ( $Validar_Import -eq $true) {
 
        $var1 = Import-Csv $Import | Select-Object -ExpandProperty DisplayName

        foreach ($var2 in $var1) {   
 
          $RoleGroup = Get-AzRoleAssignment  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2 | Select-Object -ExpandProperty RoleDefinitionName 
     
          $ScopeRBAC = Get-AzRoleAssignment  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2  | Select-Object -ExpandProperty Scope 
       
          $GroupAssignment = Get-AzRoleAssignment  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2  | Select-Object -ExpandProperty DisplayName
     
          $name = Get-AzADGroupMember -GroupDisplayName $var2  | Select-Object -ExpandProperty DisplayName 
     
          foreach ($ver in $name) { Get-AzADUser -DisplayName $ver | Select-Object DisplayName, @{n = 'SignInName'; e = { $_.Mail } }, @{n = 'RoleDefinitionName'; e = { "$RoleGroup" } }, @{n = 'Scope'; e = { "$ScopeRBAC" } }, @{n = 'associated Group'; e = { "$GroupAssignment" } } }
     
        }

      }
      else {
        Write-Host ' Csv import error
   
       Please go to ''https://github.com/Didjacome' 
      }

    }
 
    if ( $PSCmdlet.ParameterSetName -eq 'Group' ) {
    
      $ValidarGP = Get-AzRoleAssignment  |  Where-Object ObjectType -EQ Group | Where-Object DisplayName -Like $Group | Select-Object -ExpandProperty DisplayName 
     
      if ( $ValidarGP -like $Group ) {
     
        $var1 = $Group

        foreach ($var2 in $var1) {   
 
          $RoleGroup = Get-AzRoleAssignment  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2 | Select-Object -ExpandProperty RoleDefinitionName 
     
          $ScopeRBAC = Get-AzRoleAssignment  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2  | Select-Object -ExpandProperty Scope 
       
          $GroupAssignment = Get-AzRoleAssignment  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2  | Select-Object -ExpandProperty DisplayName
     
          $name = Get-AzADGroupMember -GroupDisplayName $var2  | Select-Object -ExpandProperty DisplayName 
     
          foreach ($ver in $name) { Get-AzADUser -DisplayName $ver | Select-Object DisplayName, @{n = 'SignInName'; e = { $_.Mail } }, @{n = 'RoleDefinitionName'; e = { "$RoleGroup" } }, @{n = 'Scope'; e = { "$ScopeRBAC" } }, @{n = 'associated Group'; e = { "$GroupAssignment" } } }
     
        }



      }
      else {
        Write-Host 'Group does not exist
 
        Please go to ''https://github.com/Didjacome' 
      }
    }
     
      
  }
}



 
 