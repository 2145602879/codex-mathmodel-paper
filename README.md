# MathModel Paper Suite — 本地 Codex 插件

从 MathModel desktop 0.0.21 安装包里提取的 10 个数模技能（原始 12 个中的 10 个，另 2 个见 `_parked/`），按 Codex 官方插件规范封装（`.codex-plugin/plugin.json` + `"skills": "./skills/"`），并新增一个端到端总编排技能，共 **11 个技能**。

## 在其他设备安装

### 前置条件

| 需要 | 说明 |
|---|---|
| Codex（桌面版或 CLI） | 需带 `plugin` 子命令（本插件在 `codex-cli 0.155.1` 上验证通过） |
| 获取本仓库 | 两条路：**① git 克隆**（需仓库读取权限）或 **② 离线 zip**（无需 git、无需账号） |
| （仅路线 ①）仓库读取权限 | **本仓库是私有的**：先 `gh auth login`，或让仓库所有者加你为 collaborator，或 fork 后自行决定可见性 |

### 安装步骤

**第 1 步：把仓库弄到本地。** 下文用 `<repo-root>` 指代那个目录，即**包含 `.agents/` 与 `plugins/` 的那一层**。

```bash
# 路线 ①：git 克隆
git clone https://github.com/2145602879/codex-mathmodel-paper.git
cd codex-mathmodel-paper
# 没有 gh 时可用 PAT：
# git clone https://<your-token>@github.com/2145602879/codex-mathmodel-paper.git
```

```text
路线 ②：离线 zip
把收到的 codex-mathmodel-marketplace-1.0.0.zip 解压到任意目录，
该目录就是 <repo-root>（解压后应能看到 .agents\、plugins\、README.md）。
```

**第 2~4 步**（在 `<repo-root>` 目录下执行）：

```bash
# 2. 注册为 marketplace（市场名 mathmodel-local 来自目录内的 .agents/plugins/marketplace.json）
codex plugin marketplace add "$PWD"
#   PowerShell 同样写法：codex plugin marketplace add "$PWD"

# 3. 安装并启用插件
codex plugin add "mathmodel-paper@mathmodel-local"

# 4. 确认状态（应显示 installed, enabled）
codex plugin list
```

**第 5 步：新开一个线程**（或重启 Codex）。插件的技能**只在新会话里被拾取**，之后直接说「用国赛模板开始一篇数模论文」即可触发总编排。

### 也可以手工注册

跳过第 2 步，在 `~/.codex/config.toml`（Windows：`C:\Users\<you>\.codex\config.toml`）追加（Windows 路径用单引号）：

```toml
[marketplaces.mathmodel-local]
source_type = "local"
source = '<repo-root>'

[plugins."mathmodel-paper@mathmodel-local"]
enabled = true
```

### 更新与卸载

Codex 会把插件**拷贝进缓存**（`~/.codex/plugins/cache/mathmodel-local/mathmodel-paper/<version>/`），所以 `git pull` 之后**必须重新执行 `codex plugin add`** 才会生效：

```bash
git pull
codex plugin add "mathmodel-paper@mathmodel-local"    # 重新拷贝到缓存
```

```bash
codex plugin remove "mathmodel-paper@mathmodel-local"   # 卸载插件
codex plugin marketplace remove mathmodel-local         # 移除 marketplace 注册
```

## 校验

```powershell
# 官方校验器依赖 pyyaml，裸装 python 需先装：
pip install pyyaml
python "<plugin-creator>\scripts\validate_plugin.py" "<repo-root>\plugins\mathmodel-paper"
```

> 本插件已按 `plugin-json-spec.md` 逐项自检通过：JSON 合法、`name`/`version`(严格 semver)/`description`/`author.name` 与 `interface` 必需字段齐全、无 `hooks`/`apps`/`mcpServers` 等未支持字段、无 `[TODO:]` 占位、`defaultPrompt` 3 条且均在 128 字内。

## 包含的技能（11 个）

| 技能 | 作用 |
|---|---|
| `mathmodel-paper-workflow` | **入口**：端到端总编排 + 宿主适配说明 |
| `mma-paper` | 14 套赛事 LaTeX 模板 + 论文写作纪律（123.8 MB） |
| `mathmodel-figure-templates` | 90 个可复现科研绘图模板（Python） |
| `nature-figure-mma` | Nature 级配图工作流（v2.0.0，Apache-2.0）。**宿主机已自带 `nature-figure` 时优先用宿主机的**，本副本用于目标机器没有时兜底；为免同名冲突已改名 |
| `paper-diagram` | 可编辑 draw.io 技术路线图/框架图 |
| `paper-search` | OpenAlex+Crossref → 真实 DOI BibTeX（仅标准库） |
| `data-search` | 公开数据检索、核验与来源登记 |
| `mma-figure` | 配图路由（分派给上面三个绘图技能） |
| `mma-review` | 评委视角六维度评审 → `review.md` |
| `metaheuristic-optimization` | MEALPY 智能优化实验 |
| `doctor` | 环境体检与安装向导 |

详见 `INVENTORY.md`（提取来源、依赖量化、许可证）。

## 环境要求

| 项 | 状态 | 说明 |
|---|---|---|
| Python 3.11 | 已装 | 但 site-packages 只有 pip/setuptools，**科学计算链缺失** |
| matplotlib / numpy / scipy / pandas / seaborn / cartopy / shapely | **缺** | `pip install matplotlib numpy scipy pandas seaborn cartopy shapely pyyaml python-dateutil` |
| LaTeX | **缺** | 建议启用官方 `latex@openai-bundled` 插件（自带 tectonic）；或装 TeX Live/MiKTeX（需含 ctex/xeCJK） |
| drawio CLI | 缺 | `paper-diagram` 的导出脚本需要桌面版；缺失时用其模板路径手工导出 |
| `paper-search` | ✅ 立即可用 | 仅用 Python 标准库 + 网络 |

先跑 `doctor` 技能可以自动体检并给出补齐方案。

## 未打包的技能（见 `_parked/`）

- `skill-creator` —— Codex **自带** `~/.codex/skills/.system/skill-creator`（系统技能，任何装了 Codex 的机器都有），打包属重复。
- `paper-sharing` —— **不建议使用**：设计上是「读完论文→自动删敏感信息→不询问用户→上传到数模广场」，且依赖厂商后端 MCP。

> `nature-figure` 已打包为 `nature-figure-mma`（见上表）。它与宿主机 `~/.codex/skills/nature-figure` 那份**不是同一版本**（那份 126 文件 / 33.5 MB，这份 100 文件 / 29.3 MB），属两个不同构建，所以打包并非冗余备份。

## 许可证与字体（重要）

- 只有 `nature-figure-mma`（原 `nature-figure`）、`paper-diagram`、`skill-creator` 带 LICENSE（均 Apache-2.0）；其余技能目录**没有 LICENSE**，按默认「保留所有权利」理解：自用可以，公开再分发需谨慎。
- `mma-paper` 的 123.8 MB 里约 **90 MB 是字体**，含**中易、方正的商业字体**（宋体/黑体/楷体/隶书/仿宋_GB2312/方正小标宋）。自用无妨，**不要公开再分发**；Ubuntu Mono / Fira Code / Monaco 为开源许可。
- 完整的来源、许可证与字体风险说明见 [`NOTICE.md`](NOTICE.md)。

## 远程仓库与更新

远程已配置：`origin → https://github.com/2145602879/codex-mathmodel-paper`（**私有**）。后续更新：

```powershell
cd <repo-root>
git add -A
git commit -m "更新说明"
git push
```

换台机器：见上面「**在其他设备安装**」一节（克隆 → `codex plugin marketplace add` → `codex plugin add` → 新开线程）。注意本机改完推送后，**本机也要重新执行 `codex plugin add`** 才会刷新缓存。

> 仓库含约 90 MB 商业字体，**建议保持私有**；若要公开，请先删除 `plugins/mathmodel-paper/skills/mma-paper/assets/template/*/` 下的商业字体文件（`.gitignore` 中已预置排除规则，保留 `UbuntuMono-*`、`Fira Code`、`MONACO` 等开源字体）。
