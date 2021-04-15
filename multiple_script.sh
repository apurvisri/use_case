#!/bin/bash 

VERSION="/Users/apurvisrivastava/Documents/Version/version.txt"

#Looking for version number in version.txt file
if [ -f "$VERSION" ];
then 
    SUBSTRING=`cut -d' ' -f 3 $VERSION`
#echo $SUBSTRING
else
echo "Check version.txt file again!!"
fi

# Adding file numeric pattern of shell script in array  
Script_Path="/Users/apurvisrivastava/Desktop/Apurvi/BashScripts/"
declare -a arr=() 
for name in $Script_Path/*sh;
do
arr+=( "$(sed -e s/[^0-9]//g $name)" )
done

#Itrating array and comparing it with version in version.txt file
for i in "${arr[@]}";
do 
if [[ $i -gt $SUBSTRING ]];
then 
sh $Script_Path/$i.*.sh
sum=`expr $i + 1`
else
echo "$i: conditions are not valid"
fi
done
arr=()

#Incrementing version in version.txt file as per shell script numeric pattern.
path="/Users/apurvisrivastava/Documents/Version/backup/"
TFILE="/Users/apurvisrivastava/Documents/Version/backup/tmp"
for f in $VERSION
do
  if [ -f $f -a -r $f ]; 
then
cp -f $f $path
sed "s/$SUBSTRING/$sum/g" "$f" > $TFILE && mv $TFILE "$f"
command=`cat $f`
echo "Latest: $command in version.txt file"
else
echo "Error: Cannot read $f"
fi
done
#rm "$TFILE"
