a=10
while [ $a -gt 0 ]; do   # while is used for expressions
  echo Hello World
  a=$(($a-1))
  sleep 1
done

for component in catalogue user cart frontend shipping payment ; do  # for is used for iteration
  echo Creating Component - $component
  sleep 1
done
