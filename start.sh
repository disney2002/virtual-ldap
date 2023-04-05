#!/bin/bash

while true
do
  # 检查进程是否在运行
  if ! pgrep -f "node index.js" > /dev/null
  then
    # 进程已经退出，启动新进程
    echo "start a new one:$(date)"
    nohup node index.js &
  fi
  sleep 60
done
