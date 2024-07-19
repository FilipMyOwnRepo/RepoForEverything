# Troubleshooting PowerShell

 - Run PowerShell as an Administrator
 - Try this command:
Connect-AzAccount -UseDeviceAuthentication
- If you receive an error do this command:
Install-Module -Name Az -Scope CurrentUser 
- If you receive an error do this command:
Install-Module -Name Az -Scope CurrentUser -AllowClobber

- Do again the command:
Connect-AzAccount -UseDeviceAuthentication
Click "A"

- To check the status do: 
Get-AzContext
Get-ExecutionPolicy
You should have at the last line "Unrestricted"
If not do this:
Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Unrestricted

Do again 
Get-ExecutionPolicy
Now you should have "Unrestricted" at the end.

 - Now connect
 Connect-AzAccount -UseDeviceAuthentication
 - Connect to your AZ Tenant
Connect-AzAccount -Tenant <tenant ID>
 - If needed change the Subscription
 Set-AzContext -SubscriptionName "<SubscriptionName>"
 - To check do:
 Get-AzContext

 - Now locate to the folder where is the script with "cd" command.
 - To check list all the files inside with "dir" command
 - And, at the end, execute the script (e.g. name fwexport.ps1)
 .\fwexport.ps1

 If it is not working, open the script and check first 3 lines. 
 Check first 3 variables and do these commands manually:

$fpname = "<Firewall Policy Name>"
$fprg = "<Firewall Policy Resource Group>"
$fprcgname = "<Firewall Policy Rule Collection Group Name>"

Now run the script again. It should be fine now.


At the end, file called "rule" should be in c:\temp