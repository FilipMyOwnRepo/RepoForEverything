import json
import boto3
import os

def aws_lambda(event, context):
    print(event) #ulazni podaci za aktiviranje, podaci poslati Lambda
    sns_client = boto3.client('sns') #py, kreiranje SNS klijenta, za komunikaciju (SNS i Lambda)
    sns_topic_arn = os.environ['SNS_TOPIC_ARN'] #preuzimanje ARN
    message = "Hello, world!"
    response = sns_client.publish( #publish iz boto3
        TopicArn=sns_topic_arn,
        Message=message,
        Subject='Dnevna poruka' #subject
    )