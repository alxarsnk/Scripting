#restrict pids to arr type
declare -a pids
filesCompleted=0
filesToDO=0

while getopts "d:e:n:c:" option
do
  case $option in
    e ) mask="$OPTARG";;
    d ) dirpath="$OPTARG";;
    n ) number="$OPTARG";;
    c ) executedCommand="$OPTARG";;
  esac
done

getAbsoluteFilename() {
  echo $realpath $1
}

echoCompleted(){
  echo $filesCompleted
}

echoTodo(){
  echo $filesToDO
}

#catch the signals and exute commands
trap echoCompleted SIGUSR1
trap echoTodo SIGUSR2

#wait for all pids
waitForPids() {
    wait ${pids[*]}
    ((filesCompleted++))
    ((filesToDO--))
}

#get the files confirming the mask
files=($dirpath/$mask)
for file in ${files[*]}
do
  if [ "${filesToDO}" > "${number}" ]; then
    waitForPids
  fi
    #execute the command in background and add background's pid for pids arr
    ($executedCommand $(getAbsoluteFilename $file);) &
    ((filesToDO++))
    pids+=($!)
done

while (( $filesCompleted != ${#files[*]} ))
do
  waitForPids
done
