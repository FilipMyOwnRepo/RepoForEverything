Azure firewall policy migration to FortiGate

This procedure was created fully by me to migrate Azure firewall policy to FortiGate policy. The goal was to create
the commands that will be put on FortiGate firewall. If you have FMG (FortiManager), after implementing
all the rules to FortiGate, you can import the policy to FMG easily afterwards.

The procedure for this migration is in the procedure.txt file.

I worked with C++ language. The point was to look at the yaml files like regular text files and
manipulate with them. Similar procedure could be done in Python as well. I picked up C++ because it was 
easier with sscanf function from C language to be used.

Prerequisites for this procedure is to have Visual Studio Proffesional (to debug the code), Excel, PowerShell and 
Notepad++. You would need all of these programs installed on your computer. 
