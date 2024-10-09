import pandas as pd
import requests
import getpass
session = requests.session()
username = input("Username for infoblox: ")
password = getpass.getpass()
session.auth = (username, password)
session.verify=False
readfile1 = pd.read_csv("AzureVnet2.csv", sep=";", header=1,usecols=['Name','Vnet','Subnets'])