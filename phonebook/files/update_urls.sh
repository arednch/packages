#!/bin/sh

FILE="/etc/phonebook_urls"

echo "Content-type: text/html"
echo ""

echo "<html>"
echo "<head>"
echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
echo "<title>Phonebook URL Update</title>"
echo "</head>"
echo "<body>"

if [ "$REQUEST_METHOD" == "GET" ]; then
  OLDCONTENT=$(cat ${FILE})
  echo "<form method=POST action=\"${SCRIPT}\">"
  echo "<table nowrap>"
  echo "<tr>"
  echo "<td>URLs</td>"
  echo "<td>"
  echo "<textarea id=\"urls\" name=\"urls\" rows=\"4\" cols=\"100\">"
  echo "${OLDCONTENT}"
  echo "</textarea>"
  echo "</td>"
  echo "</tr>"
  echo "</table>"

  echo "<br><input type=\"submit\" value=\"Update URLs\"></form>"
  echo "</body>"
  echo "</html>"
  exit 0
fi

if [ "$REQUEST_METHOD" == "POST" ]; then
  POST_STRING=$(cat)
  IFS=\&
  NEWCONTENT=""
  for kv in $POST_STRING ; do
    IFS==
    set -- $kv
    if [ $# -ne 2 ]; then
      echo "Not a valid key-value pair: $kv"
      continue
    fi
    if [ "${1}" != "urls" ]; then
      continue
    fi
    NEWCONTENT=$(printf '%b' "${2//%/\\x}")
  done

  if [ "${NEWCONTENT}" = "" ]
  then
    echo "urls not set"
    echo "</body>"
    echo "</html>"
    exit 1
  fi

  echo "Updating ${FILE} with content:"
  echo "<table nowrap>"
  echo "<tr>"
  echo "<td>URLs</td>"
  echo "<td>"
  echo "<textarea id=\"urls\" name=\"urls\" rows=\"4\" cols=\"100\">"
  echo "${NEWCONTENT}"
  echo "</textarea>"
  echo "</td>"
  echo "</tr>"
  echo "</table>"

  echo "${NEWCONTENT}" > ${FILE}
  echo "Done"

  echo "</body>"
  echo "</html>"
  exit 0
fi

echo "Method not supported"
echo "</body>"
echo "</html>"
exit 1
