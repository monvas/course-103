#!/bin/bash

check_wp_site() {
    local domain=$1
    echo -n "Checking $domain... "
    
    # Check if the domain is listening on port 80 (HTTP)
    nping --tcp-connect -p 80 -c 1 $domain >/dev/null 2>&1
    http_result=$?
    # echo "http_result: $http_result"

    # Check if the domain is listening on port 443 (HTTPS)
    nping --tcp-connect -p 443 -c 1 $domain >/dev/null 2>&1
    https_result=$?

    # Print the domain name
    echo "Domain: $domain"

    # Check and print the results
    if [ $http_result -eq 0 ]; then
        echo "Port 80: ok"
    else
        echo "Port 80: failure"
        exit 1
    fi

    if [ $https_result -eq 0 ]; then
        echo "Port 443: ok"
    else
        echo "Port 443: failure"
        exit 1
    fi
}

# input data for script
source data.sh

# create loop to test all sub-domains

for domain in $domains; do
    check_wp_site $domain
done

