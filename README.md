# aws-jq-cli

A simple addition to amazon/aws-cli with jq installed to process json output from the cli.


## Scripts

There is a /scripts folder where some helpful scripts reside

### getNewesVersionForDate

get the version Id of a specific date from s3. It will use the aws s3api list-object-versions command 
and process the result down to the newest version id of the files found for that date. If no files have
been found it will exit with non zero exit code. Usage

```sh
/scripts/getNewestVersionIdForDate.sh my-bucket my-file my-date additional-arguments
```

The date is a simple string comparison on the LastModified String that accepts partial matches. E.g. 2018-08-03 will return the newest file from August 3rd 2018. If you just pass 2020-08 it will look up the newest file of August.

anythin after the date will be passed through to the aws s3api list-object-versions command. So if you e.g. wanna use another endpoint and skip ssl-verification just do this like

```sh
/scripts/getNewestVersionIdForDate.sh my-bucket my-file 2020 --endpoint-url my-endpoint --no-verify-ssl
```