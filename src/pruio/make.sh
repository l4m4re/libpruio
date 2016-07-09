#! /bin/bash
echo "pasm -V3 -f -CPru_Init pasm_init.p"
pasm -V3 -f -CPru_Init pasm_init.p
echo "pasm -V3 -f -CPru_Run pasm_run.p"
pasm -V3 -f -CPru_Run pasm_run.p
#echo "fbc -w all test.bas"
#fbc -w all test.bas
