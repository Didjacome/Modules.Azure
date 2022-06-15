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
        

        function matrizContar ($inicio, $final, $de, $var2) {
          $contagem = $inicio 
          while ($contagem -le $final) {
            $RoleGroup = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).RoleDefinitionName[$contagem] 
          
            $ScopeRBAC = (Get-AzRoleAssignment -WarningAction SilentlyContinue   |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).Scope[$contagem]
      
            $GroupAssignment = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).DisplayName[$contagem]
      
            $Id = Get-AzADGroupMember -GroupDisplayName $var2  | Select-Object -ExpandProperty Id           
            foreach ($ver in $id) { Get-AzADUser -ObjectId $ver | Select-Object  @{n = 'SignInName'; e = { $_.Mail } }, @{n = 'RoleDefinitionName'; e = { "$RoleGroup" } }, @{n = 'Scope'; e = { "$ScopeRBAC" } }, @{n = 'associated Group'; e = { "$GroupAssignment" } } }              
            $contagem += $de            
          }
        }

        $i = 0
        $p = 1
        $rep = (Import-Csv $Import -UseCulture | Select-Object DisplayName | Sort-Object DisplayName | Get-Unique -AsString).DisplayName

        foreach ($d in $rep) {
          $countGp = (Get-Content $Import | Select-String -Pattern $d -CaseSensitive -SimpleMatch ).count ; $f = $countGp - 1 ;
          matrizContar -inicio $i -final $f -de $p -var $d
        }

      }
      else {
        Write-Host [' Csv import error
   
       Please go to ''https://github.com/Didjacome']  -ForegroundColor DarkRed
      }

    }
 
    if ( $PSCmdlet.ParameterSetName -eq 'Group' ) {
    
      $ValidarGP = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object DisplayName -Like $Group | Get-Unique -AsString ).DisplayName
      
      
      if ( $ValidarGP -like $Group ) {
     
        function matrizContar ($inicio, $final, $de, $var2) {
          $contagem = $inicio 
          while ($contagem -le $final) {
            $RoleGroup = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).RoleDefinitionName[$contagem] 
          
            $ScopeRBAC = (Get-AzRoleAssignment -WarningAction SilentlyContinue   |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).Scope[$contagem]
      
            $GroupAssignment = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  DisplayName -Like $var2).DisplayName[$contagem]
      
            $id = Get-AzADGroupMember -GroupDisplayName $var2  | Select-Object -ExpandProperty Id             
            foreach ($ver in $id) { Get-AzADUser -ObjectId $ver | Select-Object  @{n = 'SignInName'; e = { $_.Mail } }, @{n = 'RoleDefinitionName'; e = { "$RoleGroup" } }, @{n = 'Scope'; e = { "$ScopeRBAC" } }, @{n = 'associated Group'; e = { "$GroupAssignment" } } }              
            $contagem += $de            
          }
          
        }

        $i = 0
        $p = 1
        $rep = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object DisplayName -Like $Group | Get-Unique -AsString ).DisplayName

        foreach ($d in $rep) {
          $countGp = ((Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object DisplayName -Like $d).ObjectId).count ; $f = $countGp - 1 ;
          matrizContar -inicio $i -final $f -de $p -var $d
        }



      }

      else {
        
        $validarGPId = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object ObjectId -Like $Group | Get-Unique -AsString ).ObjectId
        if ($validarGPId -eq $Group) {
       
          function matrizContar ($inicio, $final, $de, $var2) {
            $contagem = $inicio 
            while ($contagem -le $final) {
              $RoleGroup = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  ObjectId -EQ $var2).RoleDefinitionName[$contagem] 
          
              $ScopeRBAC = (Get-AzRoleAssignment -WarningAction SilentlyContinue   |  Where-Object ObjectType -EQ Group | Where-Object  ObjectId -EQ $var2).Scope[$contagem]
      
              $GroupAssignment = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object  ObjectId -EQ $var2).DisplayName[$contagem]
      
              $Id = Get-AzADGroupMember  -GroupObjectId $var2  | Select-Object -ExpandProperty Id             
              foreach ($ver in $Id) { Get-AzADUser -ObjectId $ver | Select-Object  @{n = 'SignInName'; e = { $_.Mail } }, @{n = 'RoleDefinitionName'; e = { "$RoleGroup" } }, @{n = 'Scope'; e = { "$ScopeRBAC" } }, @{n = 'associated Group'; e = { "$GroupAssignment" } } }              
              $contagem += $de            
            }
          
          }
          $i = 0
          $p = 1
          $rep = (Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object ObjectId -Like $Group | Get-Unique -AsString ).ObjectId

          foreach ($d in $rep) {
            $countGp = ((Get-AzRoleAssignment -WarningAction SilentlyContinue  |  Where-Object ObjectType -EQ Group | Where-Object ObjectId -Like $d).ObjectId).count ; $f = $countGp - 1 ;
            matrizContar -inicio $i -final $f -de $p -var $d
          }
        }
      


        else {
        Write-Host ['Group does not exist
 
        Please go to ''https://github.com/Didjacome'] -ForegroundColor DarkRed
        }
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
      
      Update-AzTag -ResourceId $rg_id -Tag $tags -Operation Merge

      foreach ( $resource in $all_resource_id ) {

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

      Update-AzTag -ResourceId $rg_id -Tag $tags -Operation Merge

      foreach ( $resource in $all_resource_id ) {

        Update-AzTag -ResourceId $resource -Tag $tags  -Operation Merge

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
      Convert-CsvToHashtable is an advanced function that converts CSV to HashTable
    
    .DESCRIPTION
      Convert-CsvToHashtable is an advanced function that converts CSV to HashTable
    
    .EXAMPLE
      C:\PS> Convert-CsvTohashtable -Path .\variavel.csv
				
		.LINK 
      https://github.com/Didjacome

	
        
#>



function Convert-CsvTohashtable{
  param (
    # Parameter help description
    [Parameter(Mandatory)]
    [System.String]
    $Path
  )

  process {

    $csv = Import-Csv $Path -UseCulture
    $headers = $csv[0].psobject.properties.name
    $key = $headers[0]
    $value = $headers[1]
    $hashTable = @{}
    $csv | ForEach-Object { $hashTable[$_."$key"] = $_."$value" }
    return $hashTable

  }
}

 