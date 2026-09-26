---
name: mathmodel-paper-workflow
description: 数学建模竞赛论文端到端总编排（CUMCM 国赛、MCM/APMCM 美赛、华为杯、华中、五邑、统计建模等）。当用户说“写一篇数模论文”“做这道建模题”“从建模到论文走完整流程”“帮我把这篇竞赛论文跑完”时使用。按阶段调度 mma-paper、paper-search、data-search、paper-diagram、mathmodel-figure-templates、mma-review，产出可提交的 LaTeX/PDF、配图与评审报告。
---

# 数模论文全流程编排

目标产物：**可提交的论文（.tex → PDF）+ 图表源文件 + 真实参考文献 + 评审报告**。

## 阶段与调度

| 阶段 | 调用 | 产出 |
|---|---|---|
| 0 环境体检 | `doctor` | 缺失依赖清单 + 按平台的安装方案 |
| 1 读题与建模 | `mma-paper`（FIRST STEP） | 模型选择、假设、逐问求解计划 |
| 2 数据 | `data-search` | 候选来源 → 核验 → 落地文件 + 来源登记 |
| 3 求解 | `mma-paper` | **每问一个独立 `.py`**，保存后运行，不要一次求解 |
| 4 配图 | `mma-figure` 路由 → `nature-figure` / `mathmodel-figure-templates` / `paper-diagram` | `figures/` 下的图 + 可粘贴的 LaTeX 片段 |
| 5 写作与编译 | `mma-paper` | 论文 `.tex` → PDF |
| 6 参考文献 | `paper-search` | 真实 DOI 反查生成的 `book.bib` |
| 7 评审 | `mma-review` | `review.md`（六维度评分 + 按得分影响排序的改法） |

模板选择：项目里 `.mathmodel/paper/config.json` 存在则按其 `template.source` 走；不存在时中文默认 `cumcm`、英文默认 `mcm`，或由用户指定。可用模板见 `../mma-paper/assets/template/`。

## 硬性纪律（继承自 mma-paper，不可放宽）

- **参考文献必须真实**：一律经 `paper-search` 反查 DOI 生成条目追加进 `book.bib`，禁止凭记忆手写或编造题名/作者/期刊/卷期页。
- **示意图必须可编辑**：技术路线图、研究框架图、论文/算法流程图、模型架构图一律走 `paper-diagram`，优先套用其内置模板，产出 `.drawio` + PNG/PDF。
- **图注写短，解释写正文**：`\caption{}` 只写一句短图题（≤20 字，不带句号、不写结论、不逐项解释 (a)(b)）。
- **环境先行**：LaTeX 与 Python 科学计算链缺失时先补，不要把“生成了 PDF”当作字体已合格。

## 宿主适配说明（Codex 环境，已生效）

原技能出自 Claude Code 生态，本插件已做以下适配：

1. **交互提问**：原 `AskUserQuestion` → **直接用普通文本向用户提问并等待回答**；一次不超过 4 个问题，每题 2–4 个选项。
2. **浏览器**：原 `browser_*` / `mcp__mathmodel-browser__*` → 使用 Codex 的 Browser 插件（`@browser`）或等价网页抓取；不可用时如实降级并说明。
3. **项目约定目录**：`.mathmodel/paper/config.json` 保持同名约定，不存在即视为“无项目配置”，需要时可自行创建该目录，不要依赖固定的用户主目录路径。
4. **`allowed-tools` 声明已移除**（Claude 专有 frontmatter）。
5. **LaTeX**：优先用官方 `latex` 插件（bundled marketplace 里的 `latex@openai-bundled`，自带 tectonic 与 `latex-compile` / `latex-doctor` / `texlive-runtime-installer`）；也可用系统 TeX Live。
6. **字体**：`mma-paper/assets/template/<赛事>/` 下自带中文字体（宋体/黑体/楷体/隶书等），按模板的 `fonts/` 约定接入，不要静默替换字体。

## 交付前自检

- [ ] 每问都有独立求解脚本且可复现
- [ ] 所有图有源文件（`.drawio` / `.py`）而不只是位图
- [ ] `book.bib` 每条都能追到真实 DOI
- [ ] 能编译出 PDF，且日志中没有字体缺失/替代告警
- [ ] 跑过 `mma-review` 并按得分影响排序处理了问题
