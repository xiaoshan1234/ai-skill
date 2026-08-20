# UI Designer 使用

## 触发场景

- "按 X 风格做一个 Y"
- "把 DESIGN.md 转成 Tailwind config"
- "我要做一个 Linear 风格的 dashboard"
- "提取 Apple 官网的颜色/字体规范"

## 工作流程

### 例 1：生成 Linear 风格的 dashboard

```
你："按 Linear 风格做一个 dashboard"
我：
  1. 读 references/linear.app/DESIGN.md
  2. 抽取 tokens（颜色/字号/间距）
  3. 输出 tailwind.config.js + Dashboard.tsx + tokens.css
```

### 例 2：混合风格（不推荐，但支持）

```
你："Stripe 的支付页 + Linear 的 sidebar"
我：
  1. 警告：两个 design philosophy 有冲突
  2. 选一个为主（默认 Stripe），另一个为辅
  3. 输出代码，token 标注来源
```

## 可用模板（74 个）

按类别速查：

**SaaS / 工具**：
- airtable, notion, linear.app, figma, framer, intercom, posthog, sentry, superhuman, raycast, slack, miro, cal

**AI / 开发**：
- claude, minimax, opencode.ai, ollama, cursor, replicate, together.ai, mistral.ai, cohere, x.ai, voltagent

**金融**：
- stripe, coinbase, kraken, revolut, wise, binance, mastercard

**电商 / 品牌**：
- shopify, airbnb, nike, spotify, clay, sanity, mintlify, lovable, cal

**汽车 / 工业**：
- bmw, bmw-m, bugatti, ferrari, lamborghini, renault, dell-1996, hp, ibm

**消费电子 / 硬件**：
- apple, nintendo-2001, playstation, tesla, spacex, wired, theverge, warcraft

**云 / 基础设施**：
- vercel, supabase, hashicorp, clickhouse, mongodb, nvidia, resend, composio, elevenlabs, runwayml, webflow, expo, pinterest

完整列表见 `references/` 目录。

## 输出格式

- **token 文件**：`tailwind.config.js` / `tokens.css` / `theme.json`
- **组件代码**：React + TypeScript（默认）/ Vue / Svelte / SwiftUI / 纯 HTML+CSS
- **说明**：用 markdown 简述设计决策（为什么选这个字号、为什么这个颜色）

## 依赖安装

如果你要让生成代码可运行：

```bash
# React + Tailwind + shadcn/ui
npx create-next-app my-app
cd my-app
npx shadcn-ui@latest init
```

## LICENSE

`references/` 来自 [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md)，MIT License。完整 LICENSE 见 `LICENSE-VOLTAGENT.md`。