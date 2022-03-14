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
      https://github.com/Didjacome

	
        
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

	
        
#>

function Set-AzTag {


  [CmdletBinding(DefaultParameterSetName = 'TAG')]

  param (
    # Parameter help description
    [Parameter(Mandatory)]
    [System.String]
    $RG,

    [Parameter(Mandatory, ParameterSetName = 'TAG')]
    [System.String]
    $Tag_Name,
    
    [Parameter(Mandatory, ParameterSetName = 'TAG')]
    [System.String]
    $Tag_Value,

    [Parameter(Position = 0,
      Mandatory, ValueFromPipelineByPropertyName,
      ValueFromPipeline, ParameterSetName = 'CSV')]
    [System.String]
    $ImportCSV


  )

  process {
    

    Write-Verbose "ParameterSetName is '$($PSCmdlet.ParameterSetName)'"

    if ($PSCmdlet.ParameterSetName -eq 'TAG') {

      $tags = @{$Tag_Name = $Tag_Value }

      $rg_id = (Get-AzResourceGroup -Name $RG).ResourceId
  
      $all_resource_id = (Get-AzResource -ResourceGroupName $RG).ResourceId
  
      foreach ( $resource in $all_resource_id ) {
  
        Update-AzTag -ResourceId $rg_id -Tag $tags -Operation Merge
    
        Update-AzTag -ResourceId $resource -Tag $tags  -Operation Merge
      }
    }

    if ($PSCmdlet.ParameterSetName -eq 'CSV') {

      function convertCsvToHashTable($ImportCSV) {
        $csv = Import-Csv $ImportCSV -UseCulture
        $headers = $csv[0].psobject.properties.name
        $key = $headers[0]
        $value = $headers[1]
        $hashTable = @{}
        $csv | ForEach-Object { $hashTable[$_."$key"] = $_."$value" }
        return $hashTable
      }

      $tags = convertCsvToHashTable $ImportCSV

      $rg_id = (Get-AzResourceGroup -Name $RG).ResourceId

      $all_resource_id = (Get-AzResource -ResourceGroupName $RG).ResourceId

      foreach ( $resource in $all_resource_id ) {
  
        Update-AzTag -ResourceId $rg_id -Tag $tags -Operation Merge
      
        Update-AzTag -ResourceId $resource -Tag $tags  -Operation Merge
      }
    }
  
  }   
}

 