#!/bin/sh

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Multiple Queries : Primer"
echo " wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_QUERIES}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_QUERIES}
sleep 5

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Multiple Queries : Warming Up"
echo " wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_QUERIES}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_QUERIES}
sleep 5

for c in 1 5 10 15 20
do
    echo ""
    echo "---------------------------------------------------------"
    echo " Benchmarking ${FRAMEWORK}: Multiple Queries : Queries $c"
    echo " wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_QUERIES}$c"
    echo "---------------------------------------------------------"
    echo ""

    wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_QUERIES}$c 2>&1 | tee /result/queries_$c.output
    sleep 5
done
