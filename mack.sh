needles=()
command="ack"
counter=1

options=""
for i in $@
do
  if [[ $i = -* ]]; then
    options="${options} $i"
  else
    needles+=($i)
  fi
done

needlesLength=${#needles[@]}

for i in "${needles[@]}"
do
  if [ $needlesLength -eq 1 ]; then
    command="${command} ${options} -i ${i}"
  fi

  if [ $needlesLength -ne 1 -a $counter -eq 1 ]; then
    command="${command} ${options} -il ${i}"
  fi

  if [ $counter -gt 1 ] && [ $counter -ne $needlesLength ]; then
    command="${command} | ack -ixl ${i}"
  fi

  if [ $needlesLength -ne 1 ] && [ $counter -eq $needlesLength ]; then
    command="${command} | ack -ix ${i}"
  fi

  counter=$(expr $counter + 1)
done

echo "Running: ${command}"
echo ""
eval $command
