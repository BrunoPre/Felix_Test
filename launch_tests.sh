#!/bin/bash
log_file="log/trace_test.log"
echo "[Test du $(date)]" >> $log_file
robot -P "$(pwd)/SUT/remoteswinglibrary-2.3.0.jar" --RemoveKeywords "WUKS" --outputdir "$(pwd)/robot_reports" --loglevel "INFO" TV_Felix/Felix_test_CU.robot >> $log_file
echo "" >> $log_file
echo "" >> $log_file