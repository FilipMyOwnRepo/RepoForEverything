file_name = 'delete_firewall_policy.txt'

with open(file_name, 'w') as file:
   for i in range(1, 486):
       file.write(f'delete {i}\n')
