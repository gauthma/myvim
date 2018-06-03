#!/bin/bash

# Use `date` command to produce a date like so: "Monday, 5 of March of 2018", 
# and then change the day to ordinal form:  "Monday, 5th of March of 2018".

# Given a day (e.g. 5), return the corresponding ordinal (e.g. th).
function get_day_ordinal () {
  n=$1
  if [ $n -ge 11 -a $n -le 13 ] ; then
    echo "th"
  else
    case $(( $n%10 )) in
      1)
        echo st
        ;;
      2)
        echo nd
        ;;
      3)
        echo rd
        ;;
      *)
        echo th
        ;;
    esac
  fi
}

# Get the date, the day, and the corresponding ordinal...
date=$(date +"%A, %-d of %B of %Y")
day=$(date +"%-d")
ordinal=$(get_day_ordinal $day)

# ... and patch the date to add said ordinal. Echo the result.
date=${date/${day}/"${day}${ordinal}"}
echo $date

