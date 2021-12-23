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



#Check and export users
Get-AzRoleAssignment | Select-Object displayname, RoleDefinitionName, ObjectType | Where-Object ObjectType -eq User | Export-Csv  c:\users\$env:username\Documents\User_RBAC.csv

#Check and export Group
Get-AzRoleAssignment | Select-Object displayname | Where-Object ObjectType -eq Group | Export-Csv  c:\users\$env:username\Documents\Group_RBAC.csv



