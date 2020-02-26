# registration-health-checks
Daily checks and weekly reporting for umpg registration 


## configuration
<code>
55 8 * * * DAILY_LOG=/Development/source/register-daily-checks/log/register-daily-checks-`date "+\%Y-\%m-\%d"`.log; sudo /Development/source/register-daily-checks/src/main/bash/daily/register-daily-checks.sh > ${DAILY_LOG}; DISPLAY=:0 subl ${DAILY_LOG};
</code>
