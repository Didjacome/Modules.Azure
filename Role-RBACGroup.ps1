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


Param (
  [Parameter(Mandatory=$false)]
  [string]
  $grupo1,

  [Parameter(Mandatory=$false)]
  [string]
  $grupo2,


  [Parameter(Mandatory=$false)]
  [string]
  $Import

)


$Validar = Test-Path $Import 
Write-Host "$Validar"

If ( $Validar -eq $true){
Get-Content $Import| Foreach-Object{
  $var = $_.Split(';')
  New-Variable -Name $var[0] -Value $var[1] -Force
}
}

#$grupo1 = "GP-SkyOne-Contributor"

#Check the Role of the RBAC Group
$RoleGroup = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo1 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup2 = Get-AzRoleAssignment |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo2 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup3 = Get-AzRoleAssignment |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo3 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup4 = Get-AzRoleAssignment |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo4 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup5 = Get-AzRoleAssignment |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo5 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup6 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo6 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup7 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo7 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup8 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo8 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup9 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo9 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup10 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo10 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup11 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo11 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup12 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo12 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup13 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo13 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup14 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo14 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup15 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo15 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup16 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo16 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup17 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo17 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup18 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo18 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup19 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo19 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup20 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo20 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup21 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo21 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup22 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo22 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup23 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo23 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup24 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo24 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup25 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo25 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup26 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo26 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup27 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo27 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup28 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo28 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup29 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo29 | Select-Object -ExpandProperty RoleDefinitionName 
$RoleGroup30 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo30 | Select-Object -ExpandProperty RoleDefinitionName 



Write-Host "Check the Role of the RBAC Group"
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#Check hierarchical level of RBAC permission
$ScopeRBAC = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo1 | Select-Object -ExpandProperty Scope 
$ScopeRBAC2 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo2 | Select-Object -ExpandProperty Scope 
$ScopeRBAC3 =	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo3	| Select-Object -ExpandProperty Scope 
$ScopeRBAC4	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo4	| Select-Object -ExpandProperty Scope 
$ScopeRBAC5	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo5	| Select-Object -ExpandProperty Scope 
$ScopeRBAC6	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo6	| Select-Object -ExpandProperty Scope 
$ScopeRBAC7	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo7	| Select-Object -ExpandProperty Scope 
$ScopeRBAC8	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo8	| Select-Object -ExpandProperty Scope 
$ScopeRBAC9	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo9	| Select-Object -ExpandProperty Scope 
$ScopeRBAC10	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo10	| Select-Object -ExpandProperty Scope 
$ScopeRBAC11	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo11	| Select-Object -ExpandProperty Scope 
$ScopeRBAC12	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo12	| Select-Object -ExpandProperty Scope 
$ScopeRBAC13	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo13	| Select-Object -ExpandProperty Scope 
$ScopeRBAC14	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo14	| Select-Object -ExpandProperty Scope 
$ScopeRBAC15	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo15	| Select-Object -ExpandProperty Scope 
$ScopeRBAC16	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo16	| Select-Object -ExpandProperty Scope 
$ScopeRBAC17	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo17	| Select-Object -ExpandProperty Scope  
$ScopeRBAC18	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo18	| Select-Object -ExpandProperty Scope 
$ScopeRBAC19	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo19	| Select-Object -ExpandProperty Scope 
$ScopeRBAC20	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo20	| Select-Object -ExpandProperty Scope 
$ScopeRBAC21	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo21	| Select-Object -ExpandProperty Scope 
$ScopeRBAC22	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo22	| Select-Object -ExpandProperty Scope 
$ScopeRBAC23	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo23	| Select-Object -ExpandProperty Scope 
$ScopeRBAC24	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo24	| Select-Object -ExpandProperty Scope 
$ScopeRBAC25	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo25	| Select-Object -ExpandProperty Scope  
$ScopeRBAC26	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo26	| Select-Object -ExpandProperty Scope 
$ScopeRBAC27	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo27	| Select-Object -ExpandProperty Scope  
$ScopeRBAC28	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo28	| Select-Object -ExpandProperty Scope  
$ScopeRBAC29	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo29	| Select-Object -ExpandProperty Scope  
$ScopeRBAC30	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo30	| Select-Object -ExpandProperty Scope  




Write-Host "Check hierarchical level of RBAC permission"
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#Check group name
$GroupAssignment = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo1 | Select-Object -ExpandProperty DisplayName 
$GroupAssignment2 = Get-AzRoleAssignment  |  Where-Object ObjectType -eq Group | Where-Object DisplayName -like $grupo2 | Select-Object -ExpandProperty DisplayName 
$GroupAssignment3	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo3	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment4	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo4	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment5	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo5	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment6	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo6	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment7	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo7	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment8	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo8	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment9	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo9	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment10	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo10	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment11	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo11	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment12	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo12	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment13	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo13	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment14	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo14	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment15	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo15	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment16	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo16	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment17	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo17	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment18	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo18	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment19	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo19	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment20	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo20	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment21	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo21	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment22	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo22	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment23	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo23	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment24	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo24	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment25	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo25	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment26	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo26	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment27	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo27	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment28	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo28	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment29	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo29	| Select-Object -ExpandProperty DisplayName 
$GroupAssignment30	=	Get-AzRoleAssignment | Where-Object ObjectType -eq Group |	Where-Object DisplayName -like $grupo30	| Select-Object -ExpandProperty DisplayName 





Write-Host "Please wait collecting the required information"
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------#


#Collecting users
$displayNameGroup = Get-AzADGroupMember -GroupDisplayName $grupo1  | Select-Object -ExpandProperty DisplayName 
$displayNameGroup2 = Get-AzADGroupMember -GroupDisplayName $grupo2 | Select-Object -ExpandProperty DisplayName 
$displayNameGroup3	=	Get-AzADGroupMember -GroupDisplayName $grupo3	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup4	=	Get-AzADGroupMember -GroupDisplayName $grupo4	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup5	=	Get-AzADGroupMember -GroupDisplayName $grupo5	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup6	=	Get-AzADGroupMember -GroupDisplayName $grupo6	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup7	=	Get-AzADGroupMember -GroupDisplayName $grupo7	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup8	=	Get-AzADGroupMember -GroupDisplayName $grupo8	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup9	=	Get-AzADGroupMember -GroupDisplayName $grupo9	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup10	=	Get-AzADGroupMember -GroupDisplayName $grupo10	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup11	=	Get-AzADGroupMember -GroupDisplayName $grupo11	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup12	=	Get-AzADGroupMember -GroupDisplayName $grupo12	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup13	=	Get-AzADGroupMember -GroupDisplayName $grupo13	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup14	=	Get-AzADGroupMember -GroupDisplayName $grupo14	| Select-Object -ExpandProperty DisplayName  
$displayNameGroup15	=	Get-AzADGroupMember -GroupDisplayName $grupo15	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup16	=	Get-AzADGroupMember -GroupDisplayName $grupo16	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup17	=	Get-AzADGroupMember -GroupDisplayName $grupo17	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup18	=	Get-AzADGroupMember -GroupDisplayName $grupo18	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup19	=	Get-AzADGroupMember -GroupDisplayName $grupo19	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup20	=	Get-AzADGroupMember -GroupDisplayName $grupo20	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup21	=	Get-AzADGroupMember -GroupDisplayName $grupo21	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup22	=	Get-AzADGroupMember -GroupDisplayName $grupo22	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup23	=	Get-AzADGroupMember -GroupDisplayName $grupo23	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup24	=	Get-AzADGroupMember -GroupDisplayName $grupo24	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup25	=	Get-AzADGroupMember -GroupDisplayName $grupo25	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup26	=	Get-AzADGroupMember -GroupDisplayName $grupo26	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup27	=	Get-AzADGroupMember -GroupDisplayName $grupo27	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup28	=	Get-AzADGroupMember -GroupDisplayName $grupo28	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup29	=	Get-AzADGroupMember -GroupDisplayName $grupo29	| Select-Object -ExpandProperty DisplayName 
$displayNameGroup30	=	Get-AzADGroupMember -GroupDisplayName $grupo30	| Select-Object -ExpandProperty DisplayName 






Write-Host "Creating csv report"



#Exporting information
$ExportCSV = foreach ($ver in $displayNameGroup) { Get-AzADUser -DisplayName $ver | Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},@{n="RoleDefinitionName";e={"$RoleGroup"}},@{n="Scope";e={"$ScopeRBAC"}},@{n="associated group";e={"$GroupAssignment"}}}
$ExportCSV2 = foreach ($ver2 in $displayNameGroup2) { Get-AzADUser -DisplayName $ver2 | Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},@{n="RoleDefinitionName";e={"$RoleGroup2"}},@{n="Scope";e={"$ScopeRBAC2"}},@{n="associated group";e={"$GroupAssignment2"}}}
$ExportCSV3	=	foreach (	$ver3	in $displayNameGroup3	){ Get-AzADUser -DisplayName $ver3	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup3"}},@{n="Scope";e={"	$ScopeRBAC3	"}},@{n="associated group";e={"	$GroupAssignment3	"}}}
$ExportCSV4	=	foreach (	$ver4	in $displayNameGroup4	){ Get-AzADUser -DisplayName $ver4	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup4	"}},@{n="Scope";e={"	$ScopeRBAC4	"}},@{n="associated group";e={"	$GroupAssignment4	"}}}
$ExportCSV5	=	foreach (	$ver5	in $displayNameGroup5	){ Get-AzADUser -DisplayName $ver5	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup5	"}},@{n="Scope";e={"	$ScopeRBAC5	"}},@{n="associated group";e={"	$GroupAssignment5	"}}}
$ExportCSV6	=	foreach (	$ver6	in $displayNameGroup6	){ Get-AzADUser -DisplayName $ver6	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup6	"}},@{n="Scope";e={"	$ScopeRBAC6	"}},@{n="associated group";e={"	$GroupAssignment6	"}}}
$ExportCSV7	=	foreach (	$ver7	in $displayNameGroup7	){ Get-AzADUser -DisplayName $ver7	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup7	"}},@{n="Scope";e={"	$ScopeRBAC7	"}},@{n="associated group";e={"	$GroupAssignment7	"}}}
$ExportCSV8	=	foreach (	$ver8	in $displayNameGroup8	){ Get-AzADUser -DisplayName $ver8	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup8	"}},@{n="Scope";e={"	$ScopeRBAC8	"}},@{n="associated group";e={"	$GroupAssignment8	"}}}
$ExportCSV9	=	foreach (	$ver9	in $displayNameGroup9	){ Get-AzADUser -DisplayName $ver9	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup9	"}},@{n="Scope";e={"	$ScopeRBAC9	"}},@{n="associated group";e={"	$GroupAssignment9	"}}}
$ExportCSV10	=	foreach (	$ver10	in $displayNameGroup10	){ Get-AzADUser -DisplayName $ver10	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup10	"}},@{n="Scope";e={"	$ScopeRBAC10	"}},@{n="associated group";e={"	$GroupAssignment10	"}}}
$ExportCSV11	=	foreach (	$ver11	in $displayNameGroup11	){ Get-AzADUser -DisplayName $ver11	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup11	"}},@{n="Scope";e={"	$ScopeRBAC11	"}},@{n="associated group";e={"	$GroupAssignment11	"}}}
$ExportCSV12	=	foreach (	$ver12	in $displayNameGroup12	){ Get-AzADUser -DisplayName $ver12	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup12	"}},@{n="Scope";e={"	$ScopeRBAC12	"}},@{n="associated group";e={"	$GroupAssignment12	"}}}
$ExportCSV13	=	foreach (	$ver13	in $displayNameGroup13	){ Get-AzADUser -DisplayName $ver13	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup13	"}},@{n="Scope";e={"	$ScopeRBAC13	"}},@{n="associated group";e={"	$GroupAssignment13	"}}}
$ExportCSV14	=	foreach (	$ver14	in $displayNameGroup14	){ Get-AzADUser -DisplayName $ver14	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup14	"}},@{n="Scope";e={"	$ScopeRBAC14	"}},@{n="associated group";e={"	$GroupAssignment14	"}}}
$ExportCSV15	=	foreach (	$ver15	in $displayNameGroup15	){ Get-AzADUser -DisplayName $ver15	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup15	"}},@{n="Scope";e={"	$ScopeRBAC15	"}},@{n="associated group";e={"	$GroupAssignment15	"}}}
$ExportCSV16	=	foreach (	$ver16	in $displayNameGroup16	){ Get-AzADUser -DisplayName $ver16	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup16	"}},@{n="Scope";e={"	$ScopeRBAC16	"}},@{n="associated group";e={"	$GroupAssignment16	"}}}
$ExportCSV17	=	foreach (	$ver17	in $displayNameGroup17	){ Get-AzADUser -DisplayName $ver17	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup17	"}},@{n="Scope";e={"	$ScopeRBAC17	"}},@{n="associated group";e={"	$GroupAssignment17	"}}}
$ExportCSV18	=	foreach (	$ver18	in $displayNameGroup18	){ Get-AzADUser -DisplayName $ver18	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup18	"}},@{n="Scope";e={"	$ScopeRBAC18	"}},@{n="associated group";e={"	$GroupAssignment18	"}}}
$ExportCSV19	=	foreach (	$ver19	in $displayNameGroup19	){ Get-AzADUser -DisplayName $ver19	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup19	"}},@{n="Scope";e={"	$ScopeRBAC19	"}},@{n="associated group";e={"	$GroupAssignment19	"}}}
$ExportCSV20	=	foreach (	$ver20	in $displayNameGroup20	){ Get-AzADUser -DisplayName $ver20	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup20	"}},@{n="Scope";e={"	$ScopeRBAC20	"}},@{n="associated group";e={"	$GroupAssignment20	"}}}
$ExportCSV21	=	foreach (	$ver21	in $displayNameGroup21	){ Get-AzADUser -DisplayName $ver21	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup21	"}},@{n="Scope";e={"	$ScopeRBAC21	"}},@{n="associated group";e={"	$GroupAssignment21	"}}}
$ExportCSV22	=	foreach (	$ver22	in $displayNameGroup22	){ Get-AzADUser -DisplayName $ver22	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup22	"}},@{n="Scope";e={"	$ScopeRBAC22	"}},@{n="associated group";e={"	$GroupAssignment22	"}}}
$ExportCSV23	=	foreach (	$ver23	in $displayNameGroup23	){ Get-AzADUser -DisplayName $ver23	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup23	"}},@{n="Scope";e={"	$ScopeRBAC23	"}},@{n="associated group";e={"	$GroupAssignment23	"}}}
$ExportCSV24	=	foreach (	$ver24	in $displayNameGroup24	){ Get-AzADUser -DisplayName $ver24	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup24	"}},@{n="Scope";e={"	$ScopeRBAC24	"}},@{n="associated group";e={"	$GroupAssignment24	"}}}
$ExportCSV25	=	foreach (	$ver25	in $displayNameGroup25	){ Get-AzADUser -DisplayName $ver25	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup25	"}},@{n="Scope";e={"	$ScopeRBAC25	"}},@{n="associated group";e={"	$GroupAssignment25	"}}}
$ExportCSV26	=	foreach (	$ver26	in $displayNameGroup26	){ Get-AzADUser -DisplayName $ver26	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup26	"}},@{n="Scope";e={"	$ScopeRBAC26	"}},@{n="associated group";e={"	$GroupAssignment26	"}}}
$ExportCSV27	=	foreach (	$ver27	in $displayNameGroup27	){ Get-AzADUser -DisplayName $ver27	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup27	"}},@{n="Scope";e={"	$ScopeRBAC27	"}},@{n="associated group";e={"	$GroupAssignment27	"}}}
$ExportCSV28	=	foreach (	$ver28	in $displayNameGroup28	){ Get-AzADUser -DisplayName $ver28	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup28	"}},@{n="Scope";e={"	$ScopeRBAC28	"}},@{n="associated group";e={"	$GroupAssignment28	"}}}
$ExportCSV29	=	foreach (	$ver29	in $displayNameGroup29	){ Get-AzADUser -DisplayName $ver29	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup29	"}},@{n="Scope";e={"	$ScopeRBAC29	"}},@{n="associated group";e={"	$GroupAssignment29	"}}}
$ExportCSV30	=	foreach (	$ver30	in $displayNameGroup30	){ Get-AzADUser -DisplayName $ver30	| Select-Object DisplayName,@{n="SignInName";e={$_.Mail}},	@{n="RoleDefinitionName";e={"$RoleGroup30	"}},@{n="Scope";e={"	$ScopeRBAC30	"}},@{n="associated group";e={"	$GroupAssignment30	"}}}




$ExportAll = $ExportCSV + $ExportCSV2 + $ExportCSV3 + $ExportCSV4 + $ExportCSV5 + $ExportCSV6 + $ExportCSV7 + $ExportCSV8 + $ExportCSV9 + $ExportCSV10 + $ExportCSV11 + $ExportCSV12 + $ExportCSV13 + $ExportCSV14 + $ExportCSV15 + $ExportCSV16 + $ExportCSV17 + $ExportCSV18 + $ExportCSV19 + $ExportCSV20 + $ExportCSV21 + $ExportCSV22 + $ExportCSV23 + $ExportCSV24 + $ExportCSV25 + $ExportCSV26 + $ExportCSV27 + $ExportCSV28 + $ExportCSV29 + $ExportCSV30

$ExportAll | Export-Csv C:\Users\$env:USERNAME\Documents\GroupUserAll.csv

Write-Host "report has been completed"


