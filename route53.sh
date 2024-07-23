#!/bin/bash
ENV="mongodb"
IP="172.31.44.9"

aws route53 change-resource-record-sets \
    --hosted-zone-id Z001712433NLPH2AI8HH5 \
    --change-batch '{
        "Comment": "Testing creating an A record set",
        "Changes": [
            {
                "Action": "CREATE", "UPDATE",
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
