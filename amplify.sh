#!/bin/sh -l

set -e

if [ -z "$AWS_KEY" ] && [ -z "$AWS_SECRET" ] ; then
  echo "You must provide the action with both AWS_KEY and AWS_SECRET environment variables, for us to pull information about the console."
  exit 1
fi

which amplify
echo "The following amplify version $(amplify --version) is currently deployed"

# cd into the app folder
echo "cd into app folder"
cd app

case $2 in
    configure)
        aws_config="$(pwd)/aws_config_file_path.json"
        aws_config_data='{"accessKeyId":"'$AWS_KEY'","secretAccessKey":"'$AWS_SECRET'","region":"us-east-1"}'
        local_env_location="$(pwd)/amplify/.config/local-env-info.json"
        local_env_data='{"projectPath": "'"$(pwd)"'","defaultEditor":"code","envName":"'$1'"}'
        local_aws_location="$(pwd)/amplify/.config/local-aws-info.json"
        local_aws_data='{"'$1'":{"configLevel":"project","useProfile":false,"awsConfigFilePath":"'$aws_config'"}}'
        echo $aws_config_data > $aws_config
        echo $local_env_data > $local_env_location
        echo $local_aws_data > $local_aws_location
        echo "trying to find the env of $1"
        if [ -z "$(amplify env get --name $1 | grep 'No environment found')" ] ; then
          echo "found existing environment $1"
          amplify env pull --yes
        else
          echo "$1 environment does not exist, consider using add_env command instead";
          exit 1
        fi

        amplify status
        ;;
    publish)
      amplify publish -c $1 --yes
      ;;
esac