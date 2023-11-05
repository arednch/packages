#!/bin/sh

export FORCE_UPDATE="TRUE"

echo 'Content-type: text/html'
echo ''

echo '<html>'
echo '<head>'
echo '<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">'
echo '<title>AREDN local phonebook update</title>'
echo '</head>'
echo '<body>'
echo 'Trying to update the local phonebook...'
echo '<br>'
echo '<br>'

/etc/cron.hourly/fetch_phonebook
if [ $? -eq 0 ] 
then 
  echo 'Successfully updated phonebook.'
else 
  echo 'Unable to update phonebook.'
fi

echo '<br>'
echo '<br>'
echo '</body>'
echo '</html>'

unset FORCE_UPDATE

exit 0