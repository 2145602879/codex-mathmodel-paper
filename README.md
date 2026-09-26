# MathModel Paper Suite — 本地 Codex 插件

从 MathModel desktop 0.0.21 安装包里提取的 9 个数模技能，按 Codex 官方插件规范封装（`.codex-plugin/plugin.json` + `"skills": "./skills/"`），并新增一个端到端总编排技能。

## 安装

先把仓库克隆（或解压）到任意本地目录，下文用 `<repo-root>` 指代该目录，例如 `C:\Users\you\codex-mathmodel-marketplace`。

**方式一（推荐，官方对非默认 marketplace 的做法）**：

```powershell
codex plugin marketplace add "<repo-root>"
```

之后在 Codex UI 里安装 `mathmodel-paper`，**新开一个线程**即可使用（插件技能在新线程才会被拾取）。

**方式二（等价，手工注册）**：在 `~/.codex/config.toml` 追加（Windows 路径要用单引号）：

```toml
[marketplaces.mathmodel-local]
source_type = "local"
source = '<repo-root>'

[plugins."mathmodel-paper@mathmodel-local"]
enabled = true
```

## 校验

```powershell
# 官方校验器依赖 pyyaml，裸装 python 需先装：
pip install pyyaml
python "<plugin-creator>\scripts\validate_plugin.py" "<repo-root>\plugins\mathmodel-paper"
```

> 本插件已按 `plugin-json-spec.md` 逐项自检通过：JSON 合法、`name`/`version`(严格 semver)/`description`/`author.name` 与 `interface` 必需字段齐全、无 `hooks`/`apps`/`mcpServers` 等未支持字段、无 `[TODO:]` 占位、`defaultPrompt` 3 条且均在 128 字内。

## 包含的技能（10 个）

| 技能 | 作用 |
|---|---|
| `mathmodel-paper-workflow` | **入口**：端到端总编排 + 宿主适配说明 |
| `mma-paper` | 14 套赛事 LaTeX 模板 + 论文写作纪律（123.8 MB） |
| `mathmodel-figure-templates` | 90 个可复现科研绘图模板（Python） |
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

- `nature-figure` —— 本机已有一份 **Codex 原生版**（`~/.codex/skills/nature-figure`，126 文件 / 33.5 MB），与 MathModel 这份（100 文件 / 29.3 MB）**不是同一版本**。避免同名冲突与冗余，故停放。
- `skill-creator` —— Codex 自带 `~/.codex/skills/.system/skill-creator`，无需重复。
- `paper-sharing` —— **不建议使用**：设计上是「读完论文→自动删敏感信息→不询问用户→上传到数模广场」，且依赖厂商后端 MCP。

## 许可证与字体（重要）

- 只有 `nature-figure`、`paper-diagram`、`skill-creator` 带 LICENSE（均 Apache-2.0，其中两个已停放/打包内）；其余技能目录**没有 LICENSE**，按默认「保留所有权利」理解：自用可以，公开再分发需谨慎。
- `mma-paper` 的 123.8 MB 里约 **90 MB 是字体**，含**中易、方正的商业字体**（宋体/黑体/楷体/隶书/仿宋_GB2312/方正小标宋）。自用无妨，**不要公开再分发**；Ubuntu Mono / Fira Code / Monaco 为开源许可。
- 完整的来源、许可证与字体风险说明见 [`NOTICE.md`](NOTICE.md)。

## 推送到远程仓库

本地仓库已初始化并完成首次提交。创建远端并推送：

```powershell
cd <repo-root>
# 用 gh 一步创建（建议 --private）
gh repo create codex-mathmodel-paper --private --source . --push

# 或推到已存在的空仓库
git remote add origin https://github.com/<your-username>/codex-mathmodel-paper.git
git push -u origin main
```

> 仓库含约 90 MB 商业字体，**建议保持私有**；若要公开，请先删除 `plugins/mathmodel-paper/skills/mma-paper/assets/template/*/` 下的商业字体文件（保留 `UbuntuMono-*`、`Fira Code`、`MONACO` 等开源字体）。
