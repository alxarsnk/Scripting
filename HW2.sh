while getopts "d:n:" option
do
  case $option in
    n ) name="$OPTARG";;
    d ) dir="$OPTARG";;
  esac
done

#encoded files
myArch=$(tar -cz $dir | base64)

#Genereate script for unarchive
echo "myArch=\"$myArch\"
while getopts \"o:\" opt
do
    case \$opt in
    o ) dir="\$OPTARG";;
    esac
done
if [ \$dir ]; then
    echo \"\$myArch\" | base64 --decode | tar -xvz -C \$dir
else
    echo \"\$myArch\" | base64 --decode | tar -xvz
fi" > $name.sh

#Get permision for generated script
chmod 777 $name.sh
