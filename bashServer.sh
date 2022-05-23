curPath=$1

fetchRequestInput() {
    # if [[ "$CONTENT_TYPE" == "multipart/form-data;"* ]]; then
    if [[ "$in_raw" == "--------------------------"* ]]; then # have file
        boundary=$(echo -n "$in_raw" | head -1 | tr -d '\r\n')
        fileName=$(echo -n "$in_raw" | sed -n '2!d;s/\(.*filename=\"\)\(.*\)\".*$/\2/;p')
        fileContent=$(echo -n "$in_raw" | sed -n "1,/$boundary/p" | sed '1,4d;$d')
        filePath=$(tempfile)
        echo $fileContent >$filePath # save file in tmp
    else                             # have parameter
        IFS='&' read -ra params <<<"$in_raw"
        # for i in "${params[@]}"; do
        #     echo "param: $i"
        # done
    fi
}

routeRequest() {
    if [ $CONTEXT_PREFIX == "/admin/" ]; then        # for double check
        base=$(echo ${REQUEST_URI} | cut -d "/" -f3) # type
        if [ "$base" == "path1" ]; then                # git route
            operation=$(echo ${REQUEST_URI} | rev | cut -d "/" -f1 | rev) # operation https://stackoverflow.com/a/22727211/13663683
            prefix=$(echo ${REQUEST_URI} | cut -d "/" -f1-3)
            middleURI=${REQUEST_URI#"$prefix"}
            middleURI=${repoName%"$operation"}
            middleURI=${repoName:1:-1}
            case ${operation} in
            "addFile")
                source ${curPath}addFileHandler.sh ${curPath}
                ;;
            "getFile")
                source ${curPath}getFileHandler.sh ${curPath}
                ;;
            *)
                routeUndefined
                ;;
            esac
        else
            routeUndefined
        fi
    fi
}
