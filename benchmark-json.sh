#!/bin/sh

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: JSON Encoding : Primer"
echo " wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server/${URI_JSON}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server/${URI_JSON}
sleep 5

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: JSON Encoding : Warming Up"
echo " wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server/${URI_JSON}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server/${URI_JSON}
sleep 5

for c in 8 16 32 64 128 256
do
    echo ""
    echo "---------------------------------------------------------"
    echo " Benchmarking ${FRAMEWORK}: JSON Encoding : Concurency $c"
    echo " wrk --latency -d 15 -c $c -t ${BENCHMARK_CORES} http://app-server/${URI_JSON}"
    echo "---------------------------------------------------------"
    echo ""

    wrk --latency -d 15 -c $c -t ${BENCHMARK_CORES} http://app-server/${URI_JSON} 2>&1 | tee /result/json_$c.output
    sleep 5
done
