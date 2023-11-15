#!/bin/bash
nohup prefetch $(less SRR_Acc_List.txt) --max-size 30G &
