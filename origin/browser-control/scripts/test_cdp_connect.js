const fs = require('fs');
const path = require('path');
const { chromium } = require('playwright');

const DEFAULT_URL = 'https://www.baidu.com';
const DEFAULT_OUTPUT_DIR = './output';

function resolveUserPath(p) {
  const home = process.env.HOME || process.env.USERPROFILE;
  if (home && (p === '~' || p.startsWith('~/') || p.startsWith('~\\'))) {
    const rest = p === '~' ? '' : p.slice(2);
    return path.resolve(path.join(home, rest));
  }
  return path.resolve(p);
}

function looksLikeHttpUrl(s) {
  return /^https?:\/\//i.test(s);
}

function screenshotFilenameForUrl(url) {
  try {
    const host = new URL(url).hostname.replace(/[^a-zA-Z0-9.-]/g, '_');
    return `${host || 'page'}-${Date.now()}.png`;
  } catch {
    return `screenshot-${Date.now()}.png`;
  }
}

const arg1 = process.argv[2];
const arg2 = process.argv[3];

let targetUrl = DEFAULT_URL;
let outputDir = DEFAULT_OUTPUT_DIR;

if (arg1 && arg2) {
  targetUrl = arg1;
  outputDir = arg2;
} else if (arg1) {
  if (looksLikeHttpUrl(arg1)) {
    targetUrl = arg1;
  } else {
    outputDir = arg1;
  }
}

const resolvedDir = resolveUserPath(outputDir);
const screenshotPath = path.join(resolvedDir, screenshotFilenameForUrl(targetUrl));

(async () => {
  let browser;
  let page;
  try {
    browser = await chromium.connectOverCDP({ endpointURL: 'http://localhost:9222' });

    const defaultContext = browser.contexts()[0];
    page = await defaultContext.newPage();
    // 设置视口大小
    await page.setViewportSize({
      width: 1920,
      height: 1080
    });

    await page.goto(targetUrl, { waitUntil: 'networkidle', timeout: 60000 });
    await page.waitForTimeout(5000);

    fs.mkdirSync(resolvedDir, { recursive: true });
    await page.screenshot({ path: screenshotPath, fullPage: false });

    console.log('Screenshot saved:', screenshotPath);
  } finally {
    if (page) {
      await page.close().catch(() => {});
    }
    if (browser) {
      // 新版 Playwright 提供 disconnect，只断 CDP、不结束浏览器进程
      if (typeof browser.disconnect === 'function') {
        await browser.disconnect();
      }
      // 旧版无 disconnect：勿调用 browser.close()，否则会关掉整个远程调试 Chrome
    }
  }
})();
