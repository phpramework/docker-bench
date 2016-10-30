#!/bin/sh

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Single Query : Primer"
echo " wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_DB}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_DB}
sleep 5

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Single Query : Warming Up"
echo " wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_DB}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_DB}
sleep 5

for c in 8 16 32 64 128 256
do
    echo ""
    echo "---------------------------------------------------------"
    echo " Benchmarking ${FRAMEWORK}: Single Query : Concurency $c"
    echo " wrk --latency -d 15 -c $c -t ${BENCHMARK_CORES} http://app-server${URI_DB}"
    echo "---------------------------------------------------------"
    echo ""

    wrk --latency -d 15 -c $c -t ${BENCHMARK_CORES} http://app-server${URI_DB} 2>&1 | tee /result/db_$c.output
    sleep 5
done
