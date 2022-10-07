#!/bin/bash
# origin_id=`awk -F "=" 'gsub(/ /,"")' terraform.tfvars|tr -d '"' | awk -F "=" '$1 == "mediapackage_origin_id" {print $2}'`
# url=`aws mediapackage describe-origin-endpoint --id $origin_id --output text --query CmafPackage.HlsManifests[].Url`
# echo $url
# IFS='//'
# set $url
# url=$3
# url="mediapackage_url = \"$url\""
# echo $url
# sed -i "s/mediapackage\_url.*/${url}/g" terraform.tfvars
ARCHIVE_LAMBDA="archive"
VOD_LAMBDA="mediaconvert"
aws lambda update-function-code --function-name $ARCHIVE_LAMBDA --zip-file fileb://lambda/archive-mediaconvert/archive.zip
aws lambda update-function-code --function-name $VOD_LAMBDA --zip-file fileb://lambda/vod-mediaconvert/mediaconvert.zip

#UI_BUCKET="apes-frontend"
#cd frontend
#aws s3 sync . s3://$UI_BUCKET/ 
#cd ..
#aws s3 website s3://$UI_BUCKET  --index-document index.html --error-document 404.html
