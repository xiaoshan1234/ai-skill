#!/bin/bash
# 检查 todo.md：标记已过期待办；截止时间距现在 ≤30 分钟且未完成的，触发一次 send_todo 提醒。

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SEND_TODO="${SCRIPT_DIR}/send_todo.sh"

usage() {
  cat <<EOF
Usage: $(basename "$0") <todo.md路径> [send_todo额外参数...]

  读取 SKILL.md 约定的表格待办，根据「最终时间」与当前时间：
  - 已过截止且非「已完成」的，将「当前状态」改为「已过期：❌」
  - 若有未完成且未过期、且截止时间在 30 分钟内的条目，调用一次 send_todo.sh 发送提醒

  可选参数会原样传给 send_todo.sh（如 log_file、channel、target），见 send_todo.sh --help。
EOF
}

if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
  usage
  exit 0
fi

if [ -z "${1:-}" ]; then
  echo "错误: 请提供 todo.md 路径" >&2
  usage >&2
  exit 1
fi

TODO_FILE="$(eval echo "$1")"
shift || true

if [ ! -f "$TODO_FILE" ]; then
  echo "错误: 文件不存在: $TODO_FILE" >&2
  exit 1
fi

trim() {
  local s="$1"
  s="${s#"${s%%[![:space:]]*}"}"
  s="${s%"${s##*[![:space:]]}"}"
  printf '%s' "$s"
}

# 返回截止时间的 epoch；无截止或无法解析则输出空行
deadline_epoch() {
  local t
  t="$(trim "$1")"
  if [ "$t" = "无" ] || [ -z "$t" ]; then
    return 0
  fi
  if [[ "$t" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}$ ]]; then
    local y="${t:0:4}" m="${t:5:2}" d="${t:8:2}" H="${t:11:2}" M="${t:14:2}"
    date -d "${y}-${m}-${d} ${H}:${M}:00" +%s 2>/dev/null || true
    return 0
  fi
  if [[ "$t" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
    date -d "${t} 23:59:59" +%s 2>/dev/null || true
    return 0
  fi
  return 0
}

is_done() {
  [[ "$(trim "$1")" == *"已完成：✅"* ]]
}

is_expired_status() {
  [[ "$(trim "$1")" == *"已过期：❌"* ]]
}

replace_status_col() {
  local line="$1"
  local new_status="$2"
  local IFS='|'
  local -a c=()
  read -r -a c <<< "$line"
  if [ "${#c[@]}" -lt 6 ]; then
    printf '%s\n' "$line"
    return
  fi
  c[4]=" ${new_status} "
  local out="|"
  local i
  for ((i = 1; i < ${#c[@]}; i++)); do
    out="${out}${c[i]}|"
  done
  printf '%s\n' "$out"
}

now=$(date +%s)
warn_window=1800
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
needs_send=0

while IFS= read -r line || [ -n "$line" ]; do
  if [[ "$line" =~ ^\|[[:space:]]*--- ]]; then
    printf '%s\n' "$line" >>"$tmp"
    continue
  fi
  if [[ "$line" =~ 待办id ]]; then
    printf '%s\n' "$line" >>"$tmp"
    continue
  fi
  if [[ ! "$line" =~ ^\|[[:space:]]*[0-9]+[[:space:]]*\| ]]; then
    printf '%s\n' "$line" >>"$tmp"
    continue
  fi

  IFS='|' read -r -a cols <<< "$line"
  if [ "${#cols[@]}" -lt 6 ]; then
    printf '%s\n' "$line" >>"$tmp"
    continue
  fi

  id="$(trim "${cols[1]}")"
  deadline_raw="$(trim "${cols[3]}")"
  status="$(trim "${cols[4]}")"

  if ! [[ "$id" =~ ^[0-9]+$ ]]; then
    printf '%s\n' "$line" >>"$tmp"
    continue
  fi

  dl=$(deadline_epoch "$deadline_raw")
  out_line="$line"

  if is_done "$status"; then
    printf '%s\n' "$out_line" >>"$tmp"
    continue
  fi

  if [ -n "$dl" ]; then
    if [ "$now" -gt "$dl" ]; then
      if ! is_expired_status "$status"; then
        out_line="$(replace_status_col "$line" "已过期：❌")"
      fi
    elif [ "$dl" -gt "$now" ] && [ "$((dl - now))" -le "$warn_window" ]; then
      if ! is_expired_status "$status"; then
        needs_send=1
      fi
    fi
  fi

  printf '%s\n' "$out_line" >>"$tmp"
done <"$TODO_FILE"

cp "$tmp" "$TODO_FILE"

if [ "$needs_send" -eq 1 ]; then
  if [ ! -f "$SEND_TODO" ]; then
    echo "警告: 未找到 $SEND_TODO，跳过发送" >&2
  else
    bash "$SEND_TODO" "$TODO_FILE" "$@"
  fi
fi

exit 0
