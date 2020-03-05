# registration-health-checks
Daily checks and weekly reporting for umpg registration 


## configuration
<b>Reporting pop-up every day at 8:55 AM in Sublime: </b><br>
 - Clone and add to cron <br>
<code>
55 8 * * * DAILY_LOG=${PROJECT_PATH}/register-daily-checks/log/register-daily-checks-`date "+\%Y-\%m-\%d"`.log; sudo ${PROJECT_PATH}/register-daily-checks.sh > ${DAILY_LOG}; DISPLAY=:0 subl ${DAILY_LOG};
</code>
