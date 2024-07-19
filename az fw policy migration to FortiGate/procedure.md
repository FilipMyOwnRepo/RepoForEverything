# MIGRATING GROUPS AND OBJECTS 

- First part is to migrate all the groups and objects. Everything for this part is placed in "groups and objects" folder.
- You MUST have 2 files: commands_output.txt and income_rules.txt literally the same name either the code won't work. 
- Otherwise change it in the code (lines 9 and 10).

- In the "income_rules.txt" file you can put group name in one line and then IP one by one, row by row (check this file).
- Group must contain less then 101 characters or it must be changed in the code (line 22). As well, "income_rules.txt" 
file must contain less then 100 lines. 

- Be aware to put one empty line after the last IP in the group (like in income_rules.txt file). The code is searching the last line and it won't work if you forget about it. At the end, please put 2-3 empty lines. It happens that code doesn't read until the last line of code. 

- As well, be aware that you can delete characters for the Group ":" and the IPs "  - " in the code: lines 22 (group), 30 and 44 (for IPs). I had the same yaml file as put: "example.yml" so I created the code like this.

- After debbuging the code the pop-up window (command prompt) will show all the IPs (that code read). With this, I was checking if the code is working fine. Except: if there is a range, it won't be outputted!

- You just need to put all these commands to the FortiGate and... voila... all the the objects and groups are there!
--------------------------------------------------------------------------------------------------------------
# Exporting the policy

- Next step is to export the policy from Azure firewall. I found the PowerShell script on the internet:
Link: https://github.com/proximagr/automation/blob/master/Export%20Azure%20Firewall%20Policy%20Rules.ps1
You can find this script in the folder "export policy" as well.

- If it is not working, check "troubleshooting.md" file under "export policy" folder.

- At the end, file called "rule" should be in c:\temp
--------------------------------------------------------------------------------------------------------------
## Remark
If in the excel file everything is in the column A, you can change it with this:
 - Mark column A
 - Go to "Data"
 - Go to "Text to Column"
 - Mark "Delimited"
 - Mark checkbox "Comma"
 - Click "Finish"
Now everything should be in the separated column.
--------------------------------------------------------------------------------------------------------------
# WORKING WITH EXCEL AND NOTEPAD++

- I picked up Notepad++ as I like it and it was easier for me, but actually everything could be done only in Excel. Mostly everything in this step is "Find and Replace" thing.

- First find and replace in Excel is:
/subscriptions/*/resourceGroups/<RG name>/providers/Microsoft.Network/<file name>/<group name> -> ""
--------------------------------------------------------------------------------------------------------------
# CREATING SOURCE AND DESTINATION IPS ON FortiGate

- If we want to use source and destination IPs on FortiGate in the policy or to add them in the group, we need to create them first as the objects.

- The procedure is the same for both columns, but I will just mention the source IPs. 

Creating (this part is not covering the ranges so they must be rechecked and created separately !):
 - Copy the column Source IPs to the Notepad++
 - Find and replace: "," -> "\n"
 - Find and replace: " " -> ""
 - Find and replace: "\r\n\r\n" -> ""
 - Delete everything but IPs (e.g. "*" or "SourceAddresses"). You can do as well find and replace: "*" -> ""
 - Recheck the hole file again if there are any mistakes. Every IP needs to be in the separated row
 - Check the folder "migrating IPs" and file "IP_procedure.md" 
 - When you have the commands from "source_commands.txt" file, "shoot" them on FortiGate. You can do it as commands or do like script import

- Now all the source IPs are created on FortiGate. Same part of the procedure is for destination IPs. 
--------------------------------------------------------------------------------------------------------------
# ADDING THE "h-" AND "n-" TO THE IPS TO BE USED IN THE POLICY

- In the next step is to add on all source and destination IPs "h-" and "n-". In the previous step we created
all the source and destination IPs on the FortiGate with the names like e.g. 
IP: 10.0.0.1 (host)  -> Name: h-10.0.0.1
IP: 10.0.0.0/16 (network)  -> Name: n-10.0.0.0/16

This part of the procedure is most "find and replace" work:
 - Put all the IPs in one file (as "source.txt" file from 3. migrating IPs part od the procedure)
 - To delete all the commas: find and replace "," replace with ""
 - Do find: "\b(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\b" with "Regular expression" and "matchs newline". This 
 will find all the IP in the file (x.x.x.x). Replace it with "h-\1"
 - Now all the IPs (both hosts and networks) have "h-" ahead
 Next part is only to change "h-" to "n-" in networks
 - Find "\b(\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}/\d{1,2}?)\b" (finding all the networks in the file - x.x.x.x/x)
 and replace with "n-\1"
 - Now all the networks have "h-n-"
 - The prelast step is to do find and replace "h-n-" with "n-". Now all the hosts and networks have their 
 prefixes
 - Last step: do find and replace "/" and "_". We created all the networks on FortiGate like x.x.x.x_x and not
 like x.x.x.x/x!

## Sources:
- Now, copy the hole file in A column in Excel sheet. From the original excel file, copy the column with source groups to the B column (new excel sheet). In the C column do: =CONCATENATE(A1;B1) and do ti for all rows in A and B columns. 
- Do find and replace: "," -> ""
- Copy this C column to the totally new excel. There we will create hole file. It should look like "example.xlsx" excel file.

## Destinations:
- Do the same procedure for destination IPs. 
--------------------------------------------------------------------------------------------------------------
# COMMENTS

 - Copy column for comments in the new excel sheet
 - Do find and replace: " " -> ""
 - This is "must" because, if you leave comments, FortiGate won't accept it
 - Copy column to the "final" excel (like in "example.xlsx")
--------------------------------------------------------------------------------------------------------------
# PORT AND PROTOCOLS

- First create ICMP pair echo request and echo reply. This part is not covered in the C++ program. You can do it similar like this below:

FortiGate # show firewall service custom echo-request 
config firewall service custom
edit "echo-request"
set protocol ICMP
set comment "ICMP, echo request"
set color 21
set icmptype 8
unset icmpcode
next
end

FortiGate # show firewall service custom echo-reply 
config firewall service custom
edit "echo-reply"
set protocol ICMP
set comment "ICMP, echo reply"
set color 21
set icmptype 0
unset icmpcode
next
end

- Then put the hole policy in the "input.txt" file under "4 port and protocols" folder and debug the "port_protocols.cpp" file.

- There are two files: commands.txt and protokols.txt

1. In the "protokols.txt" you will have one by one all the port protocols pairs that are used in the policy. Copy this file and put it in the excel
(like in the "example.xlsx").
2. In the "commands.txt" file are the commands for creating these pairs port-protocol. Run this script on FortiGate. 

- Be aware that if you have somewhere "*" you need to fill up "ALL" manually.
--------------------------------------------------------------------------------------------------------------
# CREATING FINAL SCRIPT

- Now, when you have hole excel file, it is time to create final script. Copy hole file in the notepad. Next step is to do find/replace again in the Notepad++ to get the final policy. 

- When you copy everything from the excel file to Notepad++, you should have the same thing like in "final policy 1.txt".

Before continuing make sure that Regular expression is selected in Notepad++ finder:
 - Now select exactly like this "	set srcintf "any	" one character after "edti 1" and until the last character before "set dstintf "any"".
 - Do find and replace for: "	set srcintf "any	" -> "\nset srcintf "any""
 - Now do the same for the next command: find and replace for "set dstintf "any"	" -> "\nset dstintf "any""
 - Next is find and replace for: "set srcaddr	" -> "\nset srcaddr "
 etc etc... continue this for all. Find and replace: 
 - "	set dstaddr	" -> "\nset dstaddr "
 - "	set service	" -> "\nset service "
 - " 	set schedule always	" -> "\nset schedule always\n"
 - "	set status enable	" -> "\nset status enable\n"
 - "	set comments	" -> "\nset comments "
 - "	next" -> "\nnext"

- Now you have the script for creating the final policy!!!
- "Shoot" this on FortiGate and voila!

- The script should look like "final policy 2.txt" under "5. final policy" folder.

## Final note:
- In my policy, comments weren't that complex. If you have some complex comments be aware that FortiGate accept neither " " nor "'" or something similar. You can start the script e.g. 10 by 10 rules on the FortiGate and check if there are some issues and errors. To avoid this you can 
easily in your final script do find and replace for all of these things, e.g.:
" " - > ""
"'" -> ""
etc...

