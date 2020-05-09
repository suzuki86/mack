command="ack"
counter=1

for i in $@
do
  if [ $# -eq 1 ]; then
    command="${command} -i ${i}"
  fi

  if [ $# -ne 1 -a $counter -eq 1 ]; then
    command="${command} -il ${i}"
  fi

  if [ $counter -gt 1 ] && [ $counter -ne $# ]; then
    command="${command} | ack -ixl ${i}"
  fi

  if [ $# -ne 1 ] && [ $counter -eq $# ]; then
    command="${command} | ack -ix ${i}"
  fi

  counter=$(expr $counter + 1)
done

echo "Running: ${command}"
echo ""
eval $command
