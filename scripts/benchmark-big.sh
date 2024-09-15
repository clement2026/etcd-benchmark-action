#git clone https://github.com/clement2026/etcd.git etcd --single-branch --branch main

cd ./etcd && make build tools && chmod -R u+x ./

export RATIO_LIST="4/1"
export REPEAT_COUNT=3
export RUN_COUNT=50000

echo RATIO_LIST=$RATIO_LIST
echo REPEAT_COUNT=$REPEAT_COUNT
echo RUN_COUNT=$RUN_COUNT


cd ./tools/rw-heatmaps && ./rw-benchmark.sh