#!/bin/bash 

VERSION="/Users/apurvisrivastava/Documents/Version/version.txt"

if [ -f "$VERSION" ];
then 
    SUBSTRING=`cut -d' ' -f 3 $VERSION`
#echo $SUBSTRING
fi

Script_Path="/Users/apurvisrivastava/Desktop/Apurvi/BashScripts/"
declare -a arr=() 
for name in $Script_Path/*sh;
do
arr+=( "$(sed -e s/[^0-9]//g $name)" )
done

for i in "${arr[@]}";
do 
if [[ $i -gt $SUBSTRING ]];
then 
sh $Script_Path/$i.*.sh
sum=`expr $i + 1`
fi
done
arr=()

#`sed -i '' 's/${SUBSTRING}/${sum}/g' /Users/apurvisrivastava/Documents/Version/version.txt`

path="/Users/apurvisrivastava/Documents/Version/backup/"
TFILE="/Users/apurvisrivastava/Documents/Version/backup/tmp"
for f in $VERSION
do
  if [ -f $f -a -r $f ]; 
then
cp -f $f $path
sed "s/$SUBSTRING/$sum/g" "$f" > $TFILE && mv $TFILE "$f"
else
echo "Error: Cannot read $f"
fi
done
#rm "$TFILE"
