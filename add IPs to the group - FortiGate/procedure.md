#Procedure


1. In the "income_rules.txt" file you can put group name in one line and then IP one by one, row by row (check 
"income_rules.txt" file). Group must contain less then 101 characters or it can be changed in the code (line 22).
As well, hole file "income_rules.txt" must contain less then 100 lines. 

2. After putting the name of the group and all the IPs for that group, make an empty line! The code is searching the empty line and it 
won't work if you forget about it. At the end, please put 2-3 empty lines.

3. When you click to debbug, all the commands will be shown in "commands_output.txt" file (check this file). There will
be first the commands for creating the object (IP host, network or range with "h-", "n-" or "r-" respectively) and then there 
will be commands for adding the IP, network or range to the particular group.

4. After debbuging the code the pop-up window (command prompt) will show all the IPs (that code read). With this, I was
checking if the code is working fine.