#include <iostream>
#include <fstream>
#include <cstring> 
#include <cstdio>
#include <vector>

using namespace std;

int main() {
    ifstream file("input.txt");
    ofstream commands("commands.txt");
    ofstream protokoli("protokoli.txt");

    char line[256];

    int tcp = 0, udp = 0, icmp = 0, port_count = 0, first_icmp = 0;
    while (file.getline(line, sizeof(line))) {
        if (strcmp(line, "          - TCP") == 0) {
            tcp++;
            cout << "TCP \n";
        }
        if (strcmp(line, "          - UDP") == 0) {
            udp++;
            cout << "UDP \n";
        }
        if (strcmp(line, "          - ICMP") == 0) {
            icmp++;
            cout << "ICMP \n";
            first_icmp = 1;
        }

        if (strcmp(line, "        destinationPorts:") == 0) {
            port_count = 1;
        }

        if (strcmp(line, "        destinationPorts: ['*']") == 0) {
            protokoli << "ALL";
        }

        char port1[6], port2[6];
        if (port_count == 1 && sscanf_s(line, "          - %6[^-]-%6s", port1, sizeof(port1), port2, sizeof(port2)) == 2) {
            
            if (tcp == 1) {
                commands << "config firewall service custom" << endl;
                commands << "edit s-TCP-" << port1 << "-" << port2 << endl;
                commands << "set tcp-portrange " << port1 << "-" << port2 << endl;
                commands << "end" << endl;

                protokoli << "s-TCP-" << port1 << "-" << port2 << " ";
            }
            if (udp == 1) {
                commands << "config firewall service custom" << endl;
                commands << "edit s-UDP-" << port1 << "-" << port2 << endl;
                commands << "set udp-portrange " << port1 << "-" << port2 << endl;
                commands << "end" << endl;

                protokoli << "s-UDP-" << port1 << "-" << port2 << " ";
            }

            cout << port1 << "-" << port2 << endl;
            
        }

        char port[6];
        if (sscanf_s(line, "          - %6s", port, sizeof(port)) == 1 && port_count == 1) {
            if (tcp == 1 && strcmp(port, "8") != 0) { // it uses a TCP and makes it with used port
                commands << "config firewall service custom" << endl;
                commands << "edit s-TCP-" << port << endl;
                commands << "set tcp-portrange " << port << endl;
                commands << "end" << endl;

                protokoli << "s-TCP-" << port << " "; //what goes to excel (in protokols.txt)
            }
            if (udp == 1 && strcmp(port, "8") != 0) { // it uses a UDP and makes it with used port
                commands << "config firewall service custom" << endl;
                commands << "edit s-UDP-" << port << endl;
                commands << "set udp-portrange " << port << endl;
                commands << "end" << endl;

                protokoli << "s-UDP-" << port << " "; // what goes to excel (in protokols.txt)
            }
            cout << port << endl;
        }

        if (icmp == 1 && first_icmp == 1) {
            protokoli << "echo-request echo-reply "; // what goes to excel (in protokols.txt)
            first_icmp = 0;
        }

        if (strlen(line) == 0) {
            protokoli << endl;
            port_count = 0;
            tcp = 0;
            udp = 0;
            icmp = 0;
        }


	}
	file.close();
    commands.close();
    protokoli.close();

	return 0;
}