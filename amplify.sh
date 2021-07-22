#!/bin/sh -l

set -e

if [ -z "$AWS_KEY" ] && [ -z "$AWS_SECRET" ] ; then
  echo "You must provide the action with both AWS_KEY and AWS_SECRET environment variables, for us to pull information about the console."
  exit 1
fi

echo "$(ls)"