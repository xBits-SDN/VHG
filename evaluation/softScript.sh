while true; do export amount=`rabbitmqctl list_queues  name messages | grep "soft" | head -1|sed -e 's/.*[^0-9]\([0-9]\+\)[^0-9]*$/\1/'`; echo $(date +%s),$((amount-old)),$amount;  export old=$amount; sleep 1; done
