#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
ENV="catalogue"
IP="172.31.33.0"
# NAME="catalogue.neelareddy.store"
# VALUE="172.31.33.0"
# HOSTED="Z001712433NLPH2AI8HH5"
# ACTION="CREATE"
# TYPE="A"
# TTL="1"

VALIDATE(){
    if [ $1 -ne 0 ] 
    then
        echo -e "$2...$R FAILURE $N"
        exit1
    else
        echo -e "$2...$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit1 # manually exit if error comes.
else
    echo "You are super user."
fi

aws route53 change-resource-record-sets \
    --hosted-zone-id Z001712433NLPH2AI8HH5 \
    --change-batch '{
        "Comment": "Testing creating an A record set",
        "Changes": [
            {
                "Action": "DELETE",
                "ResourceRecordSet": {
                    "Name": "'"$ENV"'.neelareddy.store",
                    "Type": "A",
                    "TTL": 1,
                    "ResourceRecords": [
                        {
                            "Value": "'"$IP"'"
                        }
                    ]
                }
            }
        ]
    }'


# aws route53 change-resource-record-sets \
#   --hosted-zone-id $HOSTED \
#   --change-batch '{"Changes":[{"Action":"$ACTION","ResourceRecordSet":{"Name":"$NAME","Type":"$TYPE","TTL":$TTL,"ResourceRecords":[{"Value":"$VALUE"}]}}]}' &>>$LOGFILE
# VALIDATE $? "Creating the r53 record"