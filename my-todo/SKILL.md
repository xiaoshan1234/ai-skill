---
name: my-todo
description: 一个简单的待办事项列表技能，允许用户添加、查看和删除待办事项，并且可以指定时间提醒。
metadata: 
  version: "1.0.0"
---

# my-todo

## 添加/删除/标记待办
通过编辑todo.md文件来实现添加/删除/标记待办

## todo.md 格式说明
待办id : 唯一标识一个待办事项，数字递增，从1开始
待办事项 : 待办事项的具体内容，必填  
最终时间 ：待办事项的截止时间，格式为 YYYY-MM-DD-HH-mm，如果没有截止时间可以填写 "无"  ，默认是 "无"  
当前状态 ：已完成：✅, 已过期：❌, 紧急：⚠️, 未完成：⏳，默认是 "未完成"  
重要等级 ：数字，1-999，1表示不重要，999表示非常重要  默认是 1
## send_todo.sh 说明

## 

## 初始化(用户首次添加待办时)
- 按照 examples/todo.md 格式创建 todo.md 文件，默认路径是家目录
- 在crontab中添加以下条目，每天

```bash
0 21 * * * /bin/bash /home/openclaw/.openclaw/daily-openclaw-check.sh
```

### 添加一次性待办
```bash
0 21 * * * /bin/bash /home/openclaw/.openclaw/daily-openclaw-check.sh
```


### 测试连接
```bash
# 该脚本会控制浏览器打开特定网页并截图（截图文件保存在目录内，文件名含域名与时间戳）
node ~/.openclaw/skills/browser-control-js/scripts/test_cdp_connect.js [网页URL] [截图保存目录]
```
- 第一个参数：网页 url （可选，默认百度 ）
- 第二个参数：截图保存目录 （可选，默认 ./output）

### 关闭浏览器
```bash
killall chromium
```

## 异常处理
### playwright 未安装
```bash
npm init -y                 # 如果没有 package.json，先初始化
npm install playwright      # 安装 playwright 库到本地
```