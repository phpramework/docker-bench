#!/bin/sh

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Fortunes : Primer"
echo " wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_FORTUNES}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_FORTUNES}
sleep 5

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Fortunes : Warming Up"
echo " wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_FORTUNES}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_FORTUNES}
sleep 5

for c in 8 16 32 64 128 256
do
    echo ""
    echo "---------------------------------------------------------"
    echo " Benchmarking ${FRAMEWORK}: Fortunes : Concurency $c"
    echo " wrk --latency -d 15 -c $c -t ${BENCHMARK_CORES} http://app-server${URI_FORTUNES}"
    echo "---------------------------------------------------------"
    echo ""

    wrk --latency -d 15 -c $c -t ${BENCHMARK_CORES} http://app-server${URI_FORTUNES} 2>&1 | tee /result/fortunes_$c.output
    sleep 5
done
