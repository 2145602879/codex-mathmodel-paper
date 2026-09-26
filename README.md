<div align="center">

<img src="assets/banner.svg" alt="MathModel Paper Suite" width="100%">

# MathModel Paper Suite

**数学建模竞赛论文全流程 Codex 插件 —— 从读题建模到可提交 PDF，一条流水线走完。**

![version](https://img.shields.io/badge/version-1.0.2-4C8DFF)
![skills](https://img.shields.io/badge/skills-11-22D3A6)
![plugin](https://img.shields.io/badge/Codex-Plugin-6E56CF)
![platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-6E86A8)

[快速安装](#快速安装3-步) · [使用示例](#使用示例) · [环境要求](#环境要求) · [常见问题](#常见问题) · [更新记录](#更新记录)

</div>

---

## 这是什么

一套给 **Codex** 用的数学建模竞赛论文生产线。装上之后，你把题目和数据交给它，它会按阶段把活干完：

```
读题建模  →  找数据  →  逐问求解  →  配图  →  写论文  →  查文献  →  编译 PDF  →  评委式评审
```

一共 **11 个技能**，各负责一环，由一个总编排技能串起来——你只需要说一句话，不用记住哪个技能叫什么。

| 阶段 | 技能 | 干什么 |
|---|---|---|
| 🧭 总编排 | `mathmodel-paper-workflow` | 决定每一步调用谁，一路推进到交付 |
| 📄 论文 | `mma-paper` | **14 套赛事 LaTeX 模板**（国赛 / 美赛 / 华为杯 / 统计建模 / 电工杯 …）+ 写作纪律 |
| 🎨 配图 | `mma-figure` → `nature-figure-mma`、`mathmodel-figure-templates`、`paper-diagram` | 90+ 科研绘图模板、Nature 级数据图表、可编辑 draw.io 技术路线图 |
| 📚 文献 | `paper-search` | 真实 DOI 反查生成 BibTeX，**杜绝编造参考文献**（免 API key） |
| 📊 数据 | `data-search` | 找公开数据集、核验口径与许可、登记来源 |
| ✅ 评审 | `mma-review` | 评委视角六维度打分，输出 `review.md` |
| 🔧 环境 | `doctor` | 一键体检缺什么依赖，给出安装方案 |
| 🧬 优化 | `metaheuristic-optimization` | PSO / GA / DE / GWO 等智能优化实验 |

## 快速安装（3 步）

**第 1 步 · 下载**

到 [Releases](../../releases/latest) 下载 `codex-mathmodel-marketplace-1.0.2.zip`，解压到一个**新的空文件夹**（例如 `D:\codex-mathmodel`）。

**第 2 步 · 两条命令**

在**刚解压出来的那个文件夹**里执行：

```bash
codex plugin marketplace add .
codex plugin add mathmodel-paper@mathmodel-local
```

> Windows 的 PowerShell 用法完全相同。若提示找不到 `codex`，说明还没装 Codex CLI/桌面版。

<details>
<summary><b>不会命令行？「在解压出来的文件夹里执行命令」这样做（点开）</b></summary>

命令里的 `.` 意思是"**当前所在的文件夹**"，所以要先让终端站到解压出来的那个文件夹里。

**做法 A：直接在文件夹里打开终端（最省事）**

1. 用文件资源管理器打开解压出来的文件夹 —— 里面应该能看到 `plugins` 文件夹和 `README.md`
2. 点一下窗口**顶部的地址栏**（显示路径的那一行），把内容清空，输入 `cmd`，按回车
3. 弹出的黑窗口就已经"站"在这个文件夹里了
4. 粘贴下面两条命令，每条按一次回车：

   ```bash
   codex plugin marketplace add .
   codex plugin add mathmodel-paper@mathmodel-local
   ```

**做法 B：先开终端，再切进去**

1. 按 `Win + R`，输入 `cmd`，回车
2. 输入 `cd /d "你解压出来的完整路径"`，回车（`/d` 是为了能跨盘符切换，例如 `cd /d "D:\codex-mathmodel"`）
3. 再执行上面那两条命令

**怎么确认站对地方了**：输入 `dir` 回车，能看到 `plugins`、`README.md` 就对了。

**怎么粘贴**：Windows 终端里**直接点右键**即可粘贴（或 `Ctrl+Shift+V`）。

**如果提示找不到 `codex`**：说明 Codex CLI 不在 PATH。装一个：`npm i -g @openai/codex`（需要 Node.js），或把 Codex 的安装目录加进环境变量 PATH。

**如果解压后多套了一层文件夹**（例如变成 `codex-mathmodel-marketplace-1.0.2\codex-mathmodel-marketplace\`），要 `cd` 进**真正含 `.agents` 与 `plugins` 的那一层**；最省事的办法是解压时选"解压到当前文件夹"。

**macOS / Linux**：打开"终端"，输入 `cd `（注意末尾空格），把文件夹拖进终端窗口自动补全路径，回车，然后执行同样两条命令。

</details>

**第 3 步 · 重启 Codex，新开一个对话**，然后说：

> 用国赛模板开始一篇数模论文

就这一句，它会自己往下推进。

> ⚠️ 第 3 步不能省：插件技能**只在新对话里加载**，旧对话看不到。

<details>
<summary><b>不想用命令行？也可以手工注册（点开）</b></summary>

在 `~/.codex/config.toml`（Windows：`C:\Users\<你>\.codex\config.toml`）里加上这两段：

```toml
[marketplaces.mathmodel-local]
source_type = "local"
source = '刚才解压出来的目录'

[plugins."mathmodel-paper@mathmodel-local"]
enabled = true
```

</details>

<details>
<summary><b>用 git 克隆而不是下载 zip（点开）</b></summary>

```bash
git clone https://github.com/2145602879/codex-mathmodel-paper.git
cd codex-mathmodel-paper
codex plugin marketplace add .
codex plugin add mathmodel-paper@mathmodel-local
```

仓库是私有的：需要先 `gh auth login`，或让仓库所有者加你为 collaborator。

</details>

## 使用示例

装上以后，用大白话提需求就行：

| 你可以说 | 它会做 |
|---|---|
| 用国赛模板开始一篇数模论文 | 走完整流水线，最终产出 PDF |
| 用华为杯模板，题目是…… | 换成对应赛事模板 |
| 帮我找这道题需要的人口 / 气象数据 | 检索公开数据、核验来源并登记 |
| 查一下 XX 方法的文献并生成 bib | 真实 DOI 反查，生成 BibTeX |
| 给这篇论文配几张高级图 | 自动分派给合适的绘图技能 |
| 按评委视角评审我的论文 | 输出 `review.md` 评分表与改法 |
| 帮我检查环境缺什么 | 体检并给出安装命令 |

## 环境要求

| 你的目标 | 需要准备 |
|---|---|
| 论文写作、文献检索、评审（纯文字） | 一个可用的 **Codex** 就够了 |
| 要画图、跑求解程序 | **Python 3** + `pip install matplotlib numpy scipy pandas seaborn cartopy shapely pyyaml python-dateutil` |
| 要编译出 PDF | **LaTeX**：推荐在 Codex 里装官方 `latex` 插件（自带 tectonic 引擎，免配置）；也可自装 TeX Live / MiKTeX（需含 ctex / xeCJK） |

不确定缺什么？让 Codex 跑一下 `doctor`，它会逐项体检并给出方案。

## 常见问题

<details>
<summary><b>提示 No such command: plugin</b></summary>

Codex 版本较旧，先升级 Codex 再试。本插件在 `codex-cli 0.155.1` 上验证通过。

</details>

<details>
<summary><b>装完没反应，技能不触发</b></summary>

**必须新开一个对话**。插件技能只在会话启动时加载，旧对话不会自动获得。

</details>

<details>
<summary><b>我改了插件内容，怎么让它生效</b></summary>

Codex 会把插件复制到缓存目录，所以改动后要重新安装一次：

```bash
codex plugin add mathmodel-paper@mathmodel-local
```

</details>

<details>
<summary><b>怎么卸载 / 怎么确认装好了</b></summary>

```bash
codex plugin list                                    # 应显示 installed, enabled
codex plugin remove mathmodel-paper@mathmodel-local  # 卸载插件
codex plugin marketplace remove mathmodel-local      # 移除市场注册
```

</details>

<details>
<summary><b>提示找不到 .agents / 不是一个插件市场</b></summary>

你多半不在正确的那一层目录。`cd` 进**含 `.agents` 与 `plugins` 的那个文件夹**再试。若解压后多套了一层（`xxx\xxx\`），解压时选"解压到当前文件夹"即可避免。

</details>

<details>
<summary><b>终端里提示找不到 codex 命令</b></summary>

说明 Codex CLI 不在 PATH 里。三种解法，挑一个：

**① 一键脚本（最省事）**：双击运行本仓库的 `scripts\add-codex-to-path.cmd`。它会自动找到 Codex 安装目录、加进「用户 PATH」（只改用户级、不碰系统 PATH、已存在会跳过），然后**重开一个终端**即可。

**② 用 npm 装一份 CLI**（需要 Node.js）：`npm i -g @openai/codex` —— 装到的目录通常已在 PATH 里，不用手改。

**③ 手动加 PATH**：按 `Win` → 输入"环境变量" → 选「**编辑账户的环境变量**」→ 在上半部分「用户变量」里选中 `Path` → 「编辑」→ 「新建」→ 粘贴 Codex 的安装目录 → 一路「确定」→ **关掉所有终端重开**。

> 目录怎么找：打开 `C:\Users\<你>\.codex\config.toml`，搜 `CODEX_CLI_PATH`，把结尾的 `codex.exe` 去掉就是。形如 `C:\Users\<你>\AppData\Local\OpenAI\Codex\bin\<一串哈希>`——注意那串哈希每台机器都不同，不能照抄。
>
> ⚠️ 别用 `setx PATH "%PATH%;目录"`：它会把系统 PATH 与用户 PATH 合并写进用户 PATH，且超过 1024 字符会被截断，可能弄坏原有 PATH。

</details>

<details>
<summary><b>能出中文 PDF 吗</b></summary>

可以。模板自带中文字体与字体接入约定，编译时按模板的 `fonts/` 方式引用，不会静默替换字体。

</details>

## 目录结构

```
.
├── assets/banner.svg                      ← 页面横幅
├── .agents/plugins/marketplace.json       ← 插件市场清单
├── plugins/mathmodel-paper/
│   ├── .codex-plugin/plugin.json          ← 插件清单（name / version / skills）
│   ├── INVENTORY.md                       ← 技能清单与依赖说明
│   └── skills/                            ← 11 个技能
├── scripts/
│   ├── add-codex-to-path.ps1              ← 提示找不到 codex 命令时，一键加入用户 PATH
│   └── add-codex-to-path.cmd              ← 上面那个的双击版
└── _parked/                               ← 未启用的技能（附原因说明）
```

## 更新记录

### v1.0.2 — 展示与文档改版

- README 重写为产品页：三步安装、使用示例、常见问题、目录结构，安装流程对新手友好
- 新增页面横幅 `assets/banner.svg`
- 修正插件清单中的作者 / 开发者字段

### v1.0.1 — 华为杯模板升级到 2026 版

- 华为杯（中国研究生数学建模竞赛）模板全面更新：
  - 新增 **AI 使用声明**要求（程序开头保留工具名称 / 版本 / 机构 / 发布日期）
  - 对齐 2026 规则：摘要不超过两页、无需英文摘要
  - 字体改为**缺失自动回退**（Times / Courier / Arial / Consolas 不存在时回退开源等价字体），换机器不会再因字体编译失败
  - 封面标签改用随附隶书字体；修正封面页码与 PDF 锚点重复；logo 重新导出（体积减少约 72%）
- 文档同步更新

### v1.0.0 — 首次发布

- 11 个技能打包为 Codex 插件，含端到端总编排 `mathmodel-paper-workflow`
- 完成 Codex 宿主适配：交互提问改为普通文本提问；浏览器能力对接 Codex Browser 插件；移除若干专有工具依赖
- `nature-figure-mma` 采用独立命名，避免与本机同名技能冲突（本机已有 `nature-figure` 时优先用本机那份）

## 来源与许可

本仓库包含第三方技能与字体资源。**来源、许可证状况与再分发限制见 [`NOTICE.md`](NOTICE.md) —— 使用前请务必阅读。**

简要提示：仓库内含商业字体，**请勿公开再分发**；若确需公开，请先按 `.gitignore` 中预置的规则移除相关字体文件。
