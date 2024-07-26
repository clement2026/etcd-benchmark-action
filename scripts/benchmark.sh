git clone https://github.com/clement2026/etcd.git etcd --single-branch --branch main

cd ./etcd && make build tools && chmod -R u+x ./

export OUTPUT_FILE="result.csv"
export RATIO_LIST="4/1"
export REPEAT_COUNT=1
export RUN_COUNT=10000
export VALUE_SIZE_POWER_RANGE="8 8"

echo OUTPUT_FILE=$OUTPUT_FILE
echo RATIO_LIST=$RATIO_LIST
echo REPEAT_COUNT=$REPEAT_COUNT
echo RUN_COUNT=$RUN_COUNT
echo VALUE_SIZE_POWER_RANGE=$VALUE_SIZE_POWER_RANGE

cd ./tools/rw-heatmaps && ./rw-benchmark.sh