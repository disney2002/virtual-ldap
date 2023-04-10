#!/bin/bash

while true
do

  # 检查当前时间是否为凌晨4点
  if [ "$(date +%H:%M)" == "04:00" ]
  then
    # 重启服务
    echo "restarting service: $(date)"
    pkill -f "node index.js"
    nohup node index.js &
  fi

  # 检查进程是否在运行
  if ! pgrep -f "node index.js" > /dev/null
  then
    # 进程已经退出，启动新进程
    echo "start a new one: $(date)"
    nohup node index.js &
  fi
  sleep 60
done
