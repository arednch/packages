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

echo 'Trying to update the local phonebook:<br>'
echo '- fetching CSV from AREDN fileserver<br>'
echo '- updating local phonebook XML for telephones<br>'
echo '<br>'

echo 'Note: This is <b>not</b> updating the CSV from the Swiss Telephone Book (Google Sheet). Call your administrator if you need it.'
echo '<br>'

/etc/cron.hourly/fetch_phonebook &> /dev/null
if [ $? -eq 0 ] 
then 
  echo 'Successfully downloaded and created phonebooks on this router.'
else 
  echo 'Unable to download and/or create phonebook on this router.'
fi

echo '<br>'
echo '<br>'
echo '</body>'
echo '</html>'

unset FORCE_UPDATE

exit 0