# GET-RBAC


# Summary
Export Rbac permissions at different levels in CSV

# Stage
Run the Role-RBAC.ps1 script

Connect-AzAccount 

.\Role-RBAC.ps1



Open the worksheet Group_RBAC.csv


![image](https://user-images.githubusercontent.com/83463639/147241750-39772d71-957f-4753-8be1-9f749a6c7068.png)


Edit the first column by putting the group3 values



![image](https://user-images.githubusercontent.com/83463639/147241956-beeb0d6f-2660-44a7-b2ad-73e9344693b3.png)


Run the Role-RBAC script

Run the Role-RBACGoup.ps1 script

.\Role-RBACGroup.ps1 -Import c:\temp\Group_RBAC.CSV

.\Role-RBACGroup.ps1 -grupo1 Grupo-RBAC1


.\Role-RBACGroup.ps1 -grupo1 Grupo-RBAC1 -grupo2 Grupo-RBAC5









