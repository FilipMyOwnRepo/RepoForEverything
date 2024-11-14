from azure.mgmt.network import NetworkManagementClient
from azure.identity import AzureCliCredential
from azure.monitor.query import LogsQueryClient
import pairs
from functions import get_nsg_flow_logs, format_datetime
import pandas as pd
from datetime import timedelta, datetime
import pytz
import numpy as np
import xlwings as xw

credential = AzureCliCredential()
logs_client = LogsQueryClient(credential)

subscription_id = "<your subscription ID>"
workspace_id    = "<your workspace ID>" #Log Analytics

# for sub, rg in zip(pairs.subscription_id,pairs.resource_group_name,):
#     network_client = NetworkManagementClient(credential, sub)
#     vnets = network_client.virtual_networks.list(rg)
#     for vnet in vnets:
#         print(f"Name: {vnet.name}, Address Space: {vnet.address_space.address_prefixes}")


response = get_nsg_flow_logs(logs_client, workspace_id)

# for table in response.tables:
#     for row in table.rows:
#         print(row)

data = []

for table in response.tables:
    for row in table.rows:
        data.append(row) 

new_data = []

for row in data:
    formatted_datetime = format_datetime(row[0])
    new_row = f"{formatted_datetime}; {row[1]}; {row[2]}; {row[3]}; {row[4]}; {row[5]}; {row[6]}, ..."
    new_data.append(new_row) 

for row in new_data:
    print(row)

columns = ["first,column,separated,by,commas,that,you,want,to,put,in,excel"]

with xw.App(visible=True) as app: 
    wb = app.books.add()
    sh = wb.sheets[0]
    sh.range('A1').value = columns
    for i, row in enumerate(new_data, start=2): 
        sh.range(f'A{i}').value = row
    wb.save('nsg.xlsx')
    wb.close()