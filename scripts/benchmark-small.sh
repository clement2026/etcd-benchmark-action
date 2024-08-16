#git clone https://github.com/clement2026/etcd.git etcd --single-branch --branch main

cd ./etcd && make build tools && chmod -R u+x ./

export RATIO_LIST="4/1"
export REPEAT_COUNT=1
export RUN_COUNT=50000
export VALUE_SIZE_POWER_RANGE="8 8"
#export CONN_CLI_COUNT_POWER_RANGE="5 8"
export KEY_SPACE_SIZE="10000"
echo RATIO_LIST=$RATIO_LIST
echo REPEAT_COUNT=$REPEAT_COUNT
echo RUN_COUNT=$RUN_COUNT
echo VALUE_SIZE_POWER_RANGE=$VALUE_SIZE_POWER_RANGE
echo CONN_CLI_COUNT_POWER_RANGE=$CONN_CLI_COUNT_POWER_RANGE


cd ./tools/rw-heatmaps && ./rw-benchmark.sh