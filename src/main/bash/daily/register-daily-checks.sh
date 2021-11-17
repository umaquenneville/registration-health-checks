#!/bin/bash
readonly CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SQL_DIR=$(cd ../../sql/daily && pwd);
source ${CURRENT_DIR}/register-daily-checks.conf


mysql -t -v -u${PROD_AWS_RDS_USERNAME} \
  -p${PROD_AWS_RDS_PASSWORD} \
  -h${PROD_AWS_RDS_HOST} \
  -P${PROD_AWS_RDS_PORT} \
  -D${PROD_AWS_RDS_SCHEMA} < ${SQL_DIR}/register-daily-checks.sql

printf "Health of ${NAME} queue\n" 
aws sqs get-queue-attributes \
  --queue-url ${PROD_AWS_SQS_URL}/${NAME} \
  --attribute-names All
sleep 2
MESSAGES=`aws sqs get-queue-attributes \
  --queue-url ${PROD_AWS_SQS_URL}/${NAME} \
  --attribute-names All | \
  grep ApproximateNumberOfMessages*`
printf "Messages count= ${MESSAGES}\n"

printf "Health of ${NAME}-error queue\n"
aws sqs get-queue-attributes \
  --queue-url ${PROD_AWS_SQS_URL}/${PROD_APP_NAME}-error \
  --attribute-names All
sleep 2
MESSAGES=`aws sqs get-queue-attributes \
  --queue-url ${PROD_AWS_SQS_URL}/${NAME}-error \
  --attribute-names All | \
  grep ApproximateNumberOfMessages*`
printf "Messages count= ${MESSAGES}\n"

# todo add sentry
#curl -H 'Authorization: Bearer ${auth_key}' http://sentry/api/0/projects/sentry/?statsPeriod=24h | jq -r '.[].title' | sort | uniq -c > log/last24hr.log
