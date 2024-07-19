## Azure firewall policy migration to FortiGate

- This procedure was created to migrate Azure firewall policy to FortiGate policy. The goal was to create
the commands that will be put on FortiGate firewall. If you have FMG (FortiManager), after implementing
all the rules and objects to FortiGate, you can import the policy to FMG easily afterwards.

- The procedure for this migration is in the procedure.md file.

- I worked with C++ language. The point was to look at the yaml files like regular text files and
manipulate with them. Similar procedure could be done in Python as well. I picked up C++ because it was 
easier with sscanf function from C language to be used.

- Prerequisites for this procedure is to have Visual Studio Proffesional (to debug the code in C++), Excel, 
PowerShell and Notepad++. You would need all of these programs installed on your computer. 

- For almost all parts of the procedure I had a yaml files for ip_groups and rules, so I used these files and 
manipulated them. Be aware that you would need to download them from Azure portal before starting. The examples will be placed in particular folders.

