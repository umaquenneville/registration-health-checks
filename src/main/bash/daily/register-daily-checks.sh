#!/bin/bash
source daily/register-daily-checks.conf
cd /Development/source/register-daily-checks/src/main/sql
mysql -t -v -u${PROD_AWS_RDS_USERNAME} -p${PROD_AWS_RDS_PASSWORD} -h${PROD_AWS_RDS_HOST} -P${PROD_AWS_RDS_PORT} -D${PROD_AWS_RDS_SCHEMA} < daily/register-daily-checks.sql

printf "Health of umpg-register-prod-work-generator queue\n" 
aws sqs get-queue-attributes --queue-url ${PROD_AWS_SQS_URL}/umpg-register-prod-work-record --attribute-names All
sleep 2
MESSAGES=`aws sqs get-queue-attributes --queue-url ${PROD_AWS_SQS_URL}/umpg-register-prod-work-record --attribute-names All | \
    grep ApproximateNumberOfMessages*`
printf "Messages count= ${MESSAGES}\n"

printf "Health of umpg-register-prod-work-generator-error queue\n"
aws sqs get-queue-attributes --queue-url ${PROD_AWS_SQS_URL}/umpg-register-prod-work-record-error --attribute-names All
sleep 2
MESSAGES=`aws sqs get-queue-attributes --queue-url ${PROD_AWS_SQS_URL}/umpg-register-prod-work-record-error --attribute-names All | \
    grep ApproximateNumberOfMessages*`
printf "Messages count= ${MESSAGES}\n"

# todo add sentry
#curl -H 'Authorization: Bearer ${auth_key}' http://sentry.umpgapps.com:8080/api/0/projects/sentry/register-prod/issues/?statsPeriod=24h | jq -r '.[].title' | sort | uniq -c > log/register-prod-last24hr.log
