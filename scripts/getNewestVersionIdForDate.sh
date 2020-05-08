
BUCKET=$1
FILENAME=$2
DATE=$3

shift 3
BYPASS=$@

if [[ $1 == "help" ]]; then
  echo -e "\n\nUse to get the VersionId of the newest File. Use with following arguments \n\
  1. BUCKET-NAME\n\
  2. FILENAME\n\
  3. DATE \n\
    (e.g. 2020-05-07). Partial matches can be used. For example 2020-05 will return the newest Version Id of May 2020\n\n \
  4. BYPASS Any arguments following will be passed to the aws s3api list-object-versions command"
  
  exit 0;
fi

if [[ -z $BUCKET ]]; then
  echo "No Bucket name provided as first argument"
  exit 1
elif [[ -z $FILENAME ]]; then
  echo "No Filename provided as second argument"
  exit 1
elif [[ -z $DATE ]]; then  
  echo "No Date Provided as third argument"
  exit 1
else
  RESULT=$(aws s3api list-object-versions --bucket $BUCKET --prefix $FILENAME $BYPASS | jq -r --arg DATE "$DATE" '.Versions[] | select(.LastModified | . and contains($DATE)) | .VersionId' | head -n 1)
  if [[ $RESULT == "" ]]; then
    echo "File/Bucket not found"
    exit 1
  elif [[ $RESULT == "null" ]]; then
    echo "VersionId is null. Are you sure you enabled versioning?"
    exit 1
  else
    echo $RESULT
  fi
fi