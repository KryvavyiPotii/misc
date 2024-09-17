#!/bin/bash

# Dump several objects of a PDF file at once with pdf-parser.py.

integer_re='^[0-9]+$'
usage_message="USAGE: $0 object1 object2 ... objectN pdfFile"

if [[ $# < 3 ]] ; then
  echo "error: Too few arguments"
  echo "$usage_message"
fi

for object in "$@"
do
  if [[ $object == "${@: -1}" ]] ; then
    break
  fi
  
  if ! [[ $object =~ $integer_re ]] ; then
    echo "error: Not a number" >&2
    exit 1
  fi

  pdf-parser.py -o $object -f -d "obj$object.dump" ${@: -1}
done

