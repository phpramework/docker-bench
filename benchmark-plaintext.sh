#!/bin/sh

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Plain Text"
echo "---------------------------------------------------------"
echo ""

rm /result/plaintext.output

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Plain Text : Primer"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server/${URI_PLAINTEXT}

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: Plain Text : Warming Up"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server/${URI_PLAINTEXT}

for c in 8 16 32 64 128 256
do
    echo ""
    echo "---------------------------------------------------------"
    echo " Benchmarking ${FRAMEWORK}: Plain Text : Concurency $c"
    echo "---------------------------------------------------------"
    echo ""
    wrk --latency -d 15 -c $c -t ${BENCHMARK_CORES} http://app-server/${URI_PLAINTEXT} 2>&1 | tee /result/plaintext_$c.output
done

echo ""
echo "---------------------------------------------------------"
echo " Finished benchmarking ${FRAMEWORK}: Plain Text"
echo "---------------------------------------------------------"
echo ""
