#!/usr/bin/env python

import glob
import json
import os
import uuid
import boto3
import datetime
import random
import json, os

from botocore.client import ClientError


def handler(event, context):
    assetID = str(uuid.uuid4())
    sourceS3Bucket = event['Records'][0]['s3']['bucket']['name']
    input_file_key = event['Records'][0]['s3']['object']['key']

    mediaConvertRole = os.environ['MediaConvertRole']
    region = os.environ['AWS_DEFAULT_REGION']
    
    s3 = boto3.client('s3')
    body = {}
    output_bucket_name = os.environ["DestinationBucket"]

    # Use MediaConvert SDK UserMetadata to tag jobs with the assetID
    # Events from MediaConvert will have the assetID in UserMedata
    jobMetadata = {'assetID': assetID}

    print(json.dumps(event)) 
    current_time = datetime.datetime.now().strftime("%m-%d-%Y, %H:%M:%S")
    folder_name = "stream_"+current_time

    try:
        s3.copy_object(Bucket = sourceS3Bucket, CopySource = {'Bucket' : sourceS3Bucket, 'Key': input_file_key}, Key= "archive-copy/{}/{}".format(folder_name,input_file_key))

        with open('job.json') as job_file:
            data =  json.load(job_file)

        for item in data['Inputs']:
            item['FileInput'] = item['FileInput'].replace(item['FileInput'],"s3://{}/archive-copy/{}/".format(sourceS3Bucket,folder_name)+input_file_key)

        for k,v in data['OutputGroups'][0]['OutputGroupSettings']['HlsGroupSettings'].items():
            if k == 'Destination':
                data['OutputGroups'][0]['OutputGroupSettings']['HlsGroupSettings']['Destination'] = v.replace(v,"s3://{}/archive/assets/HLS/{}/".format(output_bucket_name,folder_name))
        for k,v in data['OutputGroups'][1]['OutputGroupSettings']['FileGroupSettings'].items():
            if k == 'Destination':
                data['OutputGroups'][1]['OutputGroupSettings']['FileGroupSettings']['Destination'] =   v.replace(v,"s3://{}/archive/assets/Thumbnails/{}/".format(output_bucket_name,folder_name))       
        with open('/tmp/job.json','w') as job_file:
            json.dump(data,job_file,sort_keys=True,indent=2)
        s3.delete_object(Bucket = sourceS3Bucket, Key = input_file_key)
    except Exception as e:
        print('Exception: %s' % e)
        statusCode = 500
    try:
        # Job settings are in the lambda zip file in the current working directory
        with open('/tmp/job.json') as json_data:
            jobSettings = json.load(json_data)
            print(jobSettings)

        # get the account-specific mediaconvert endpoint for this region
        mc_client = boto3.client('mediaconvert', region_name=region)
        endpoints = mc_client.describe_endpoints()

        # add the account-specific endpoint to the client session
        client = boto3.client('mediaconvert', region_name=region, endpoint_url=endpoints['Endpoints'][0]['Url'],
                              verify=False)

        print('jobSettings:')
        print(json.dumps(jobSettings))

        # Convert the video using AWS Elemental MediaConvert
        job = client.create_job(Role=mediaConvertRole, UserMetadata=jobMetadata, Settings=jobSettings)
        print(json.dumps(job, default=str))

    except Exception as e:
        print ('Exception: %s' % e)
        statusCode = 500
        raise

    finally:
        return {
            'statusCode': statusCode,
            'body': json.dumps(body),
            'headers': {'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'}
        }