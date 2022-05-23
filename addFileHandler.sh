curPath=$1

handler(){
    checkMissingInput fileName $fileName
    echo "running node file: node ${curPath}addFile.js $REMOTE_USER $REMOTE_ADDR $middleURI $fileName $filePath"
    node ${curPath}addFile.js $REMOTE_USER $REMOTE_ADDR $middleURI $fileName $filePath
}
