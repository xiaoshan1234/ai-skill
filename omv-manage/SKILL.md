---
name: omv-manage
description: >-
  Manage an OpenMediaVault (OMV) host: shared folders, SMB/NFS/FTP/SSH services,
  RAID/mdadm/LUKS/SMART, OMV-Extras / Docker / Plex / qBittorrent, plus
  systemd, cron, firewall, rsync, auto-mount, and UPS. Use when the user asks
  to operate, configure, troubleshoot, or automate anything on an OMV box
  (Web UI, omv-rpc / omv-confdbadm via SSH, or hybrid). Triggers include
  phrases like "OMV", "OpenMediaVault", "共享文件夹", "SMB", "NFS", "RAID",
  "快照", "Docker 插件", "OMV-Extras", "omv-rpc", "config.xml", "systemd 服务".
metadata:
  topic: openmediavault
  language: zh
---

# OMV (OpenMediaVault) 系统管理

OMV = Debian + 自家 Web UI + `omv-rpc` 后端。**两件事先认清**：
1. 几乎所有"在 Web UI 里点 Apply"的操作，本质都是改 `/etc/openmediavault/config.xml`，再由 `omv-engined` 写回 systemd/服务文件。绕过 Web UI 直接改 `config.xml` 是可以的，但**改完必须** `omv-confdbadm update` 或 `omv-salt deploy` 才能生效。
2. 文件系统 UUID/挂载点用 `/srv/dev-disk-by-uuid-xxxx/...`（由 `omv-salt deploy` 生成），**不要硬编码 `/dev/sda1` 这种会漂移的名字**。

---

## 何时用 / 何时不用

用本 skill：配置共享、SMB/NFS、RAID/快照、插件服务、systemd 单元、cron、备份（rsync/snapraid）、防火墙、UPS、故障排查。

不用本 skill：纯 Debian 软件包管理（`apt`）、纯 Docker 容器运维（走 `docker` skill）、网络设备本体（走路由器 skill）、备份目标非本机（走远端 skill）。

---

## 三种操作入口

按场景分支。优先 Web UI（最安全），其次 SSH + `omv-rpc`（批量/自动化），最后直接改文件（兜底，谨慎）。

### 1. Web UI（默认入口，适合一次性变更）

`https://<omv-host>`，账号 `admin`。改完点右上角黄色 **Apply** 才会真生效，**漏点 Apply 是最常见的"为什么改了没效果"原因**。

适用：建共享文件夹、改 SMB 设置、装插件、看 SMART、看 RAID 状态。

### 2. SSH + `omv-rpc`（批量 / 脚本化）

OMV Web UI 后端走的就是 RPC，CLI 等价命令：

```bash
# 列所有已挂载文件系统
omv-rpc -u admin 'FileSystemMgmt' 'enumerateMountedFilesystems' '{"includeroot": true}'

# 列 RAID 可用候选盘（建 RAID 前查）
omv-rpc -u admin 'RaidMgmt' 'getCandidates' | jq

# 列已配置共享文件夹
omv-rpc -u admin 'ShareMgmt' 'enumerateSharedFolders'
```

适用：批量建用户/共享、做幂等脚本、CI 里"确保某配置存在"。

### 3. 直接改文件（兜底，仅在你知道后果时）

```bash
# 数据库 XML（所有"配置"真相之源）
/etc/openmediavault/config.xml
/etc/openmediavault/config.xml.d/          # 插件扩展

# 生成的运行时服务/单元（每次 Apply 会重生成）
/etc/samba/smb.conf                         # ← OMV 生成，别手改
/etc/exports                                # ← NFS 生成
/etc/fstab                                  # OMV 只管 data mount，root 在这里

# 改完 XML 必须：
omv-confdbadm update                       # 让 omv-engined 感知
omv-salt deploy run systemd                # 把变更推到 systemd
# 或者直接：
monit restart omv-engined                  # 重启引擎最稳
```

⚠️ `config.xml` 被改坏 → `omv-engined` 启动失败 → Web UI 404。改前先 `cp config.xml{,.bak}`。

---

## 子系统速查（按需展开）

### 文件共享

**SMB/CIFS（最常用）**
- Web UI：`Services → SMB/CIFS → Settings` 启用，`Shares` 添加（指向已建好的 Shared Folder）。
- CLI 看共享列表：`omv-rpc -u admin 'SMB' 'getShareList' | jq '.[]|.name'`。
- 权限坑：OMV 的 SMB 权限是 **共享文件夹 ACL** × **SMB 自身 ACL** 两层。只在 Web UI 的共享文件夹里设权限不够，还需要在 SMB 共享的"Extra options"或 ACL 里再设一次。
- macOS 时间机器：建一个 SMB 共享，`min protocol = SMB2`，`vfs objects = catia fruit streams_xattr`，否则 Time Machine 会失败。

**NFS**
- Web UI：`Services → NFS` 启用 + 添加 share；客户端挂载时 OMV 默认 `secure, subtree_check`。
- 客户端：`mount -t nfs <omv-host>:/export/path /mnt`。

**FTP / SSH**
- FTP 用 SFTP 替代（`Services → SFTP` 或直接用系统 sshd）。
- SSH：`PermitRootLogin no`，OMV 默认就是 `no`，改的话走 `/etc/ssh/sshd_config` 然后 `systemctl restart ssh`。

### 存储

**mdadm RAID**
- 状态：`cat /proc/mdstat`，健康：`omv-rpc -u admin 'RaidMgmt' 'getList' | jq`。
- 重建监控：`watch -n 30 cat /proc/mdstat`，**不要在重建期间断电/重启**。
- SMART：`Storage → S.M.A.R.T.` 设定时自检（`smartctl -t short` 周，`-t long` 月）。

**LUKS 加密盘**
- OMV 6+ 支持 GUI 建 LUKS；CLI 流程：`cryptsetup luksFormat /dev/sdX` → `cryptsetup open` → 建文件系统 → 在 OMV 里挂载（OMV 会接管密钥槽管理）。
- 重要：**重装系统前必须导出 LUKS header 备份**：`cryptsetup luksHeaderBackup /dev/sdX -h backup.bin`，丢 header = 丢全盘数据。

**snapraid（OMV-Extras 插件）**
- 用途：异速备份（多盘 + 一块 parity），适合大冷数据。
- `scrub` 计划走 OMV 的 Scheduled Tasks，**每月一次足够**，频繁 scrub 写放大伤盘。

**mergerfs（多盘合并池）**
- 用 `Storage → mergerfs`（OMV-Extras）把多块盘合成一个逻辑视图 `/srv/mergerfs/...`。
- 坑：mergerfs 不是 RAID，**没有冗余**，任何一块挂了只丢那块的数据。要冗余就 snapraid + mergerfs 组合。

### 插件 / 容器（OMV-Extras）

- 装 Extras：`wget -O - https://github.com/orgs/openmediavault-plugins/packages/container/package/omvextras | bash`（OMV 7 用 docker 镜像版，命令以官方 README 为准）。
- `omvextras` 装好后会出现 `OMV-Extras` 左侧菜单。
- **Docker** 走 `openmediavault-compose` 插件（或 Portainer），**不要**手动 `apt install docker.io`，会和 OMV 的 systemd unit 冲突。
- Plex / qBittorrent / Syncthing 都有官方插件，能走插件就走插件，配置会被纳入 OMV 的备份策略。

### 系统服务与运维

**systemd**
- 看 OMV 自己管的服务：`systemctl list-units 'omv*'`。
- 自定义单元放 `/etc/systemd/system/`，`omv-salt deploy` 不会覆盖这里。
- 重启策略：`Storage → Scheduled Tasks` 里的"Power Management"里有 Wake-on-LAN/定时开关。

**cron / Scheduled Tasks**
- Web UI：`System → Scheduled Tasks` 加。用户级 cron 优先这里加（记录在 `config.xml`），不要 `crontab -e`（会被 OMV 周期清理/覆盖）。

**防火墙**
- OMV 7 默认 nftables 后端：`System → Firewall` 加规则，**Web UI 加完会自动 Apply**。
- SSH 改端口后记得在防火墙开新端口，**否则你自己会被锁在外面**。

**rsync 备份**
- Web UI：`System → Rsync` 配 job，源用 `Shared Folder` 比 `Directory` 更稳（路径不漂移）。
- 推送/拉取选错模式会变成双向覆盖，先在测试目录跑一次 `--dry-run`。

**自动挂载**
- 非 OMV 管的外接盘：`/etc/fstab` 用 `UUID=` 而不是 `/dev/sdX`；`nofail` 选项防止外接盘没接导致系统起不来。

**UPS**
- 走 `apcupsd` 或 `nut`，OMV 插件 `nut` 较新。**先在断电演练前把通知脚本测通**——UPS 没接好时只会默默停机。

---

## 常见故障（优先看这节）

| 现象 | 第一查 |
|------|--------|
| Web UI 改了没生效 | 右上角有没有 Apply？Apply 后有没有变绿勾？ |
| Web UI 502/404 | `systemctl status omv-engined`，多半是 `config.xml` 改坏 |
| SMB 看不到共享 | `testparm -s`，再看 ACL / 共享文件夹权限两层 |
| RAID 盘掉了 | `cat /proc/mdstat` + `journalctl -u mdadm`，先 `mdadm --detail /dev/md0` 看状态 |
| 共享里中文文件名乱码 | SMB 全局 `unix charset = utf-8`，macOS 客户端加 `vers=3.0` |
| 磁盘满了但 df 看没满 | `du -sh /srv/dev-disk-by-*/|sort -h`，OMV 会保留 5% 给 root |
| 插件装不上 | `omv-extras` 仓库源是否失效，先 `omv-update` |

---

## 自检清单

做任何 OMV 变更前：
- [ ] 知道目标子系统（共享 / RAID / 插件 / 服务），避免跨层乱改
- [ ] 是否需要 Apply 或 `omv-salt deploy`，改完**确认已生效**再走
- [ ] LUKS / RAID 重大操作前，**有没有离线备份 config.xml + 关键数据**
- [ ] 防火墙 / SSH 端口变更有没有"留逃生通道"（控制台或 KVM）

变更后：
- [ ] `systemctl status omv-engined` 绿
- [ ] Web UI 登录正常，无 Apply 残留
- [ ] 关键共享实测一次（不是只看状态绿灯）