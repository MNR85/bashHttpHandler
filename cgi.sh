#!/bin/bash

srcPath="handler_path/"
source ${srcPath}bashServer.sh $srcPath
source ${srcPath}error.sh


# defining cgi response format
echo "Content-type: text/html"
echo ""

# checking request type
checkRequestType

# some log, inputs are env variable from apache cgi
echo "v1.03"
echo "Request in $REQUEST_URI from $REMOTE_USER with size $CONTENT_LENGTH with $REQUEST_METHOD"

# fetch inputs
if [ "$CONTENT_LENGTH" -gt 0 ]; then # include content
    in_raw="$(cat)"
    # echo "$in_raw"
    fetchRequestInput
fi

routeRequest # find request route
if [[ $(type -t handler) == function ]]; then
    handler # automatically handle request
fi

exit 0
