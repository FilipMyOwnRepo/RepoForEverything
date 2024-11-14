from azure.monitor.query import LogsQueryClient
from datetime import timedelta, datetime
import pytz
import os

def get_nsg_flow_logs(logs_client, workspace_id):
    query = r""" query #you can find the example on log analytic workspace
    """   

    timespan = timedelta(days=1)
    response = logs_client.query_workspace(workspace_id, query,timespan=timespan)
    
    return response

##########################################################################################

def format_datetime(dt):
    #dt_without_timezone = dt.astimezone(pytz.UTC).replace(tzinfo=None)
    dt_without_timezone = dt.astimezone(pytz.timezone('Europe/Belgrade')).replace(tzinfo=None)
    date_str = dt_without_timezone.strftime('%m/%d/%Y')
    time_str = dt_without_timezone.strftime('%I:%M:%S.%f %p')
    return f"{date_str}, {time_str}"
