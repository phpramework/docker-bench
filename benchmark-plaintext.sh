#!/bin/sh

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Plain Text : Primer"
echo " wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_PLAINTEXT}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_PLAINTEXT}
sleep 5

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Plain Text : Warming Up"
echo " wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_PLAINTEXT}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_PLAINTEXT}
sleep 5

for c in 8 16 32 64 128 256
do
    echo ""
    echo "---------------------------------------------------------"
    echo " Benchmarking ${FRAMEWORK}: Plain Text : Concurency $c"
    echo " wrk --latency -d 15 -c $c -t ${BENCHMARK_CORES} http://app-server${URI_PLAINTEXT}"
    echo "---------------------------------------------------------"
    echo ""

    wrk --latency -d 15 -c $c -t ${BENCHMARK_CORES} http://app-server${URI_PLAINTEXT} 2>&1 | tee /result/plaintext_$c.output
    sleep 5
done
