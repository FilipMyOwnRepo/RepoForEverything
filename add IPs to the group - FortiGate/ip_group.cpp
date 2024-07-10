#include <iostream>
#include <fstream>
#include <cstring> 
#include <cstdio>

using namespace std;

int main() {
    ifstream file("income_rules.txt");  //put group and IP
    ofstream commands("commands_output"); //output of commands

    char line[256];
    string ip_addresses[100], fw_address_group;

    int ip_index = 0, ip_index_range = 0;
    int first_line = 1;
    string new_mask = "";

    while (file.getline(line, sizeof(line))) { //reading the line one by one
        char group_name[50];
        
        if (sscanf_s(line, "%100", group_name, sizeof(group_name)) == 1 && first_line == 1) { //group in the first line
            fw_address_group = group_name;
        }

        char ip[18], address[15];
        char ip1[18], ip2[18];
        int mask = 0;

        if (sscanf_s(line, "%15[^-]-%15s", ip1, sizeof(ip1), ip2, sizeof(ip2)) == 2 && first_line != 1) { //reading the IPs, if it is the range

            commands << "config firewall address" << endl; //commands that will be put on FortiGate
            commands << "edit r-" << ip1 << "-" << ip2 << endl;
            commands << "set type iprange" << endl;
            commands << "set start-ip " << ip1 << endl;
            commands << "set end-ip " << ip2 << endl;
            commands << "end" << endl;
            commands << "config firewall addrgrp" << endl;
            commands << "edit" << " " + fw_address_group << endl;
            commands << "append member r-" << ip1 << "-" << ip2 << endl;
            commands << "end" << endl;
            cout << ip1 << "-" << ip2 << endl;
        }
        else {
            if (sscanf_s(line, "%15s", ip, sizeof(ip)) == 1 && first_line != 1) { //IP is host or network
                ip_addresses[ip_index++] = ip;

                if (sscanf_s(ip, "%15[^/]/%2d", address, sizeof(address), &mask, sizeof(mask)) == 2) { //IP is network, e.g ip = 192.168.40.0/21
                    switch (mask) {  //switch for mask
                    case 32:
                        new_mask = "255.255.255.255";
                        break;
                    case 31:
                        new_mask = "255.255.255.254";
                        break;
                    case 30:
                        new_mask = "255.255.255.252";
                        break;
                    case 29:
                        new_mask = "255.255.255.248";
                        break;
                    case 28:
                        new_mask = "255.255.255.240";
                        break;
                    case 27:
                        new_mask = "255.255.255.224";
                        break;
                    case 26:
                        new_mask = "255.255.255.192";
                        break;
                    case 25:
                        new_mask = "255.255.255.128";
                        break;
                    case 24:
                        new_mask = "255.255.255.0";
                        break;
                    case 23:
                        new_mask = "255.255.254.0";
                        break;
                    case 22:
                        new_mask = "255.255.252.0";
                        break;
                    case 21:
                        new_mask = "255.255.248.0";
                        break;
                    case 20:
                        new_mask = "255.255.240.0";
                        break;
                    case 19:
                        new_mask = "255.255.224.0";
                        break;
                    case 18:
                        new_mask = "255.255.192.0";
                        break;
                    case 17:
                        new_mask = "255.255.128.0";
                        break;
                    case 16:
                        new_mask = "255.255.0.0";
                        break;
                    case 15:
                        new_mask = "255.254.0.0";
                        break;
                    case 14:
                        new_mask = "255.252.0.0";
                        break;
                    case 13:
                        new_mask = "255.248.0.0";
                        break;
                    case 12:
                        new_mask = "255.240.0.0";
                        break;
                    case 11:
                        new_mask = "255.224.0.0";
                        break;
                    }

                    commands << "config firewall address" << endl;
                    commands << "edit n-" << address << "_" << mask << endl;
                    commands << "set subnet " << address << " " << new_mask << "\n";
                    commands << "end" << endl;
                    commands << "config firewall addrgrp" << endl;
                    commands << "edit" << " " + fw_address_group << endl;
                    commands << "append member n-" << address << "_" << mask << endl;
                    commands << "end" << "\n";
                }

                else { //the only left, IP is host e.g. 192.168.0.1
                    commands << "config firewall address" << endl;
                    commands << "edit h-" << ip << endl;
                    commands << "set subnet " << ip << " 255.255.255.255" << "\n"; //addition for th host
                    commands << "end" << endl;
                    commands << "config firewall addrgrp" << endl;
                    commands << "edit" << " " + fw_address_group << endl;
                    commands << "append member h-" << ip << endl;
                    commands << "end" << "\n";
                }

                cout << ip_addresses[ip_index - 1] << endl; //range won't be on the output
            }
        }

        first_line++;

        if (strlen(line) == 0) {
            first_line = 1;
        }
    }

    file.close();
    commands.close();
    return 0;
}