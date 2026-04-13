---
name: browser-control
description: 使用 node.js 来控制浏览器，例如打开网页截图，获取网页内容
metadata: 
  dependencies: ["playwright"] # 可选，声明依赖的库
  tools: ["node", "npm"] # 可选，声明依赖的工具
  version: "1.0.0"
---

# browser-control

## 快速使用

### 启动浏览器
```bash
# 无头模式启动浏览器，只需要启动一次 
chromium --headless=new --remote-debugging-port=9222 --user-data-dir=$HOME/.config/chromium --no-sandbox --disable-gpu  &
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