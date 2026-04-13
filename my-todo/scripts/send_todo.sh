#!/bin/bash
# 每天早晚发送 todo.md 内容到飞书

TODO_FILE="${1:-~/todo.md}"
LOG_FILE="${2:-~/.openclaw/logs/send_todo.log}"
CHANNEL="${3:-qqbot}"
TARGET="${4:-100D297F270B79304A426354A832CA96}"

# 展示用法
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    cat <<EOF
Usage: $(basename "$0") [todo_file] [log_file] [channel] [target]

  todo_file   : todo.md 文件路径，默认 ~/todo.md
  log_file    : 日志文件路径，默认 ~/.openclaw/logs/send_todo.log
  channel     : openclaw 通道，默认 qqbot
  target      : 目标用户/群 id，默认 100D297F270B79304A426354A832CA96
EOF
    exit 0
fi

# 展开 ~ 为绝对路径
TODO_FILE="$(eval echo "$TODO_FILE")"
LOG_FILE="$(eval echo "$LOG_FILE")"

# 创建日志目录
mkdir -p "$(dirname "$LOG_FILE")"

# 检查文件是否存在
if [ ! -f "$TODO_FILE" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') ERROR: todo.md not found at $TODO_FILE" >> "$LOG_FILE"
    exit 1
fi

# 读取内容并通过 openclaw message send 发送
CONTENT=$(cat "$TODO_FILE")
echo "$(date '+%Y-%m-%d %H:%M:%S') Sending todo.md from $TODO_FILE..." >> "$LOG_FILE"

~/.npm-global/bin/openclaw message send --channel "$CHANNEL" --target "$TARGET" -m "$CONTENT" 2>&1 >> "$LOG_FILE"

if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Send success" >> "$LOG_FILE"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') Send failed" >> "$LOG_FILE"
fi
