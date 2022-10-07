#!/bin/bash
BACKEND_BUCKET="apes-dev-backend"
ELEMENTAL_VOD_INPUT_BUCKET="apes-dev-media-input-vod"
ELEMENTAL_ARCHIVE_INPUT_BUCKET="apes-dev-media-input-archive"
ELEMENTAL_OUTPUT_BUCKET="apes-dev-media-output"
UI_BUCKET="apes-dev-frontend"
DD_TABLE="apes-terraform-state-lock-table"

if aws s3 ls "s3://$BACKEND_BUCKET" 2>&1 | grep -q 'NoSuchBucket'
then
echo "Creating the backend bucket ..."
aws s3 mb s3://$BACKEND_BUCKET --region us-east-1
if [[ $? == 0 ]];
then
echo "bucket created"
aws s3api put-public-access-block \
    --bucket $BACKEND_BUCKET \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
aws s3api put-bucket-tagging --bucket $BACKEND_BUCKET --tagging "TagSet=[{Key=Project, Value=APES}]"
aws s3api put-object --bucket $BACKEND_BUCKET --key lambda/
fi
else
echo "The bucket exists .... not creating"
fi


echo "Zipping the lambda code and sending to s3 bucket ${BACKEND_BUCKET}"
cd lambda/vod-mediaconvert
zip -r mediaconvert.zip .
ls -l
aws s3 cp mediaconvert.zip "s3://${BACKEND_BUCKET}/lambda/vod-mediaconvert/mediaconvert.zip"
cd ../archive-mediaconvert
zip -r archive.zip .
ls -l
aws s3 cp archive.zip "s3://${BACKEND_BUCKET}/lambda/archive-mediaconvert/archive.zip"
cd ../..


if aws s3 ls "s3://$ELEMENTAL_VOD_INPUT_BUCKET" 2>&1 | grep -q 'NoSuchBucket'
then
echo "Creating the input bucket ..."
aws s3 mb s3://$ELEMENTAL_VOD_INPUT_BUCKET --region us-east-1
if [[ $? == 0 ]];
then
echo "bucket created"
aws s3api put-public-access-block \
    --bucket $ELEMENTAL_VOD_INPUT_BUCKET \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
aws s3api put-bucket-tagging --bucket $ELEMENTAL_VOD_INPUT_BUCKET --tagging "TagSet=[{Key=Project, Value=APES}]"
aws s3api put-object --bucket $ELEMENTAL_VOD_INPUT_BUCKET --key vod/
#aws s3api put-object --bucket $ELEMENTAL_INPUT_BUCKET --key archive/latest/
fi
else
echo "The bucket exists .... not creating"
fi

if aws s3 ls "s3://$ELEMENTAL_ARCHIVE_INPUT_BUCKET" 2>&1 | grep -q 'NoSuchBucket'
then
echo "Creating the backend bucket ..."
aws s3 mb s3://$ELEMENTAL_ARCHIVE_INPUT_BUCKET --region us-east-1
if [[ $? == 0 ]];
then
echo "bucket created"
aws s3api put-public-access-block \
    --bucket $ELEMENTAL_ARCHIVE_INPUT_BUCKET \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
aws s3api put-bucket-tagging --bucket $ELEMENTAL_ARCHIVE_INPUT_BUCKET --tagging "TagSet=[{Key=Project, Value=APES}]"
aws s3api put-object --bucket $ELEMENTAL_ARCHIVE_INPUT_BUCKET --key latest/
fi
else
echo "The bucket exists .... not creating"
fi


if aws s3 ls "s3://$ELEMENTAL_OUTPUT_BUCKET" 2>&1 | grep -q 'NoSuchBucket'
then
echo "Creating the input bucket ..."
aws s3 mb s3://$ELEMENTAL_OUTPUT_BUCKET --region us-east-1
if [[ $? == 0 ]];
then
echo "bucket created"
aws s3api put-public-access-block \
    --bucket $ELEMENTAL_OUTPUT_BUCKET \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
aws s3api put-bucket-tagging --bucket $ELEMENTAL_OUTPUT_BUCKET --tagging "TagSet=[{Key=Project, Value=APES}]"

aws s3api put-object --bucket $ELEMENTAL_OUTPUT_BUCKET --key archive/
aws s3api put-object --bucket $ELEMENTAL_OUTPUT_BUCKET --key vod/

fi
else
echo "The bucket exists .... not creating"
fi


if aws s3 ls "s3://$UI_BUCKET" 2>&1 | grep -q 'NoSuchBucket'
then
echo "Creating the input bucket ..."
aws s3 mb s3://$UI_BUCKET --region us-east-1
if [[ $? == 0 ]];
then
echo "bucket created"
aws s3api put-public-access-block \
    --bucket $UI_BUCKET \
    --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

aws s3api put-bucket-tagging --bucket $UI_BUCKET --tagging "TagSet=[{Key=Project, Value=APES}]"
cd ui
aws s3api put-object --bucket $UI_BUCKET --key ui/
aws s3 sync . s3://$UI_BUCKET/ui/ 
cd ..
aws s3 website s3://$UI_BUCKET  --index-document index.html --error-document 404.html

fi
else
echo "The bucket exists .... not creating"
fi


OUTPUT=`aws dynamodb describe-table \
                    --table-name $DD_TABLE 2>&1`

if [[ $OUTPUT == *"(ResourceNotFoundException)"* ]]; 
then 

echo "The lock table doesn't exist .... creating now"
aws dynamodb create-table --table-name $DD_TABLE \
                          --billing-mode PAY_PER_REQUEST \
                          --attribute-definitions AttributeName=LockID,AttributeType=S \
                          --key-schema AttributeName=LockID,KeyType=HASH 
else
echo "The lock table exists so not creating"
fi


echo "Copying all the cloudformation templates to s3 bucket .."
aws s3 sync "cf-templates/" "s3://$BACKEND_BUCKET/cf-templates/"

