# MathModel 内置技能提取清单

从 MathModel desktop（数模 Agent）安装包里提取出来的 12 个内置技能，供在 Codex / DSH / Claude Code 等其他 Agent 里复用。

## 来源与可复现步骤

| 项 | 值 |
|---|---|
| 安装包 | `mathmodel-0.0.22-x64.exe`（316.3 MB）；0.0.21 为 314.6 MB，两版均已核对 |
| 包格式 | NSIS-3 Unicode，Deflate |
| 解包链 | NSIS → `$PLUGINSDIR\app-64.7z`（329 MB，LZMA2+BCJ2）→ `resources\builtin-skills\` |
| 使用工具 | NVIDIA App 自带的完整 7-Zip 22.01（`C:\Program Files\NVIDIA Corporation\NVIDIA App\7z.exe`，带 `7z.dll`，支持 NSIS） |
| 提取结果 | **12 个技能 / 658 文件 / 197.0 MB** |
| 旁证 | `resources\claude-code\claude.exe` 285 MB（第 16 行左右的清单里可见）、`resources\app.asar` 77.6 MB（Electron 应用代码，未解） |

**交叉验证**：提取出的每个技能的体积与文件数，和该 App 实际 seed 到 `%APPDATA%\@mathmodel\desktop\skills-plugin\skills\` 的那一份**逐项一致**（42.0MB/195、123.8MB/208、29.3MB/100、1.8MB/132、7、5、3、1、1、2、1、3）→ 说明安装包里的载荷就是运行时使用的那份内容。

**未完成的一步**：`seeded-builtins.json` 里记录了 12 个技能的 SHA256 指纹，但试了「文件原始字节」和「CRLF→LF 规范化」两种算法都对不上，厂商用的应是对排序后的「路径 + 内容」整树做摘要。未继续深挖，现有证据已足够确认内容一致性。

## 技能清单与宿主依赖

`AskUserQuestion` / `browser_*` / `.mathmodel/` / `MCP` 四列 = 该技能正文里出现的宿主专有依赖次数（0 = 不依赖 MathModel 环境，可直接搬）。

| 技能 | 体积 | 文件 | LICENSE | AskUser | browser_* | .mathmodel/ | MCP | 移植档 |
|---|---|---|---|---|---|---|---|---|
| `mma-paper` | 123.8 MB | 208 | 无 | 2 | 0 | 2 | 0 | 要改造 |
| `mathmodel-figure-templates` | 42.0 MB | 195 | 无 | 0 | 0 | 0 | 0 | **即用** |
| `nature-figure` | 29.3 MB | 100 | **Apache-2.0** | 0 | 0 | 0 | 0 | **即用** |
| `paper-diagram` | 1.8 MB | 132 | **Apache-2.0** | 0 | 0 | 0 | 0 | **即用** |
| `skill-creator` | ~0 | 7 | **Apache-2.0** | 0 | 0 | 0 | 0 | **即用** |
| `paper-search` | ~0 | 2 | 无 | 0 | 0 | 0 | 0 | **即用** |
| `mma-review` | ~0 | 1 | 无 | 0 | 0 | 0 | 0 | **即用** |
| `mma-figure` | ~0 | 1 | 无 | 0 | 0 | 0 | 0 | **即用** |
| `metaheuristic-optimization` | ~0 | 1 | 无 | 0 | 0 | 0 | 0 | **即用** |
| `doctor` | ~0 | 3 | 无 | 2 | 0 | 0 | 0 | 要改造 |
| `data-search` | ~0 | 3 | 无 | 0 | 5 | 0 | 1 | 要改造 |
| `paper-sharing` | ~0 | 1 | 无 | 0 | 0 | 0 | 1 | **不建议移植** |

### 各技能干什么

- `mma-paper` — 数学建模竞赛论文全流程：**14 套赛事 LaTeX 模板**（apmcm、apmcm-en、changsanjiao、cumcm、diangongbei、dongsansheng、huashubei、huawei、huazhong、mathorcup、mcm、shuweibei、stats、wuyi），逐问建模求解 → 撰写 → 绘图 → 编译
- `mathmodel-figure-templates` — 可复现科研绘图模板库（模型评估、统计分布、多变量分析等），带 cartopy 地图 shapefile
- `nature-figure` — Nature 级期刊配图工作流（Python/R，matplotlib/seaborn + ggplot2/patchwork/ComplexHeatmap）
- `paper-diagram` — draw.io 可编辑示意图（技术路线图/研究框架图/流程图模板 + 布局校验与导出脚本）
- `paper-search` — OpenAlex + Crossref 双引擎文献检索与 BibTeX 生成（免 API key）
- `mma-review` — 以竞赛评委视角按六维度评审论文，输出 `review.md`
- `mma-figure` — 配图路由器，把需求分派给上面两个绘图技能
- `metaheuristic-optimization` — MEALPY 智能优化实验（PSO/GA/DE/GWO…）
- `doctor` — 环境体检与安装向导（CUMCM LaTeX、Python 科学计算、科研绘图、Git，含大陆镜像方案）
- `data-search` — 公开数据集检索/核验/登记（依赖内置 `browser_*` 工具）
- `skill-creator` — 造新技能的元技能
- `paper-sharing` — 把论文 PDF 上传到 MathModel 数模广场

## 移植注意

1. **8/12 零宿主依赖，可以直接搬**（上表「即用」档）。它们只要求目标 Agent 认 `SKILL.md` 格式（YAML frontmatter 的 `name` / `description` + 渐进式引用 `references/`、`assets/`、`scripts/`）。
2. **需要改造的三个**：
   - `doctor`、`mma-paper`：用了 `AskUserQuestion`（交互提问工具），换成目标 Agent 的等价物即可
   - `mma-paper`：正文引用 `.mathmodel/paper/config.json` 项目约定，需改为自己的路径约定（或建同名目录）
   - `data-search`：依赖 5 处 `browser_*` 工具 + MCP，目标环境没有浏览器工具时要替换或降级为 WebSearch/WebFetch
3. **`paper-sharing` 建议直接删除**：它的设计是「读完论文全文 → 自动删掉它认为的敏感信息 → 不询问用户 → 上传到数模广场」，且依赖厂商后端的 MCP 工具。放进自己的 Agent 等于埋一个不可控的出网通道。
4. **字体版权（重要）**：`mma-paper` 的 123.8 MB 里约 **90 MB 是字体**，其中宋体/黑体/楷体/隶书/仿宋_GB2312/方正小标宋属于**中易、方正的商业字体**（`LiSu.ttf` 与系统 `C:\Windows\Fonts\SIMLI.TTF` 哈希完全相同，其余来自第三方 GitHub 转载库）。自用无妨，**不要公开再分发**；Ubuntu Mono / Fira Code / Monaco 是开源许可，可自由处理。
5. **许可证**：只有 `nature-figure`、`paper-diagram`、`skill-creator` 带 LICENSE（均为 Apache-2.0）；其余 9 个目录内**没有 LICENSE**，按默认「保留所有权利」理解 —— 自己用可以，对外发布要谨慎。

## 目录结构

```
mathmodel-skills\
├─ INVENTORY.md            ← 本文件
├─ mma-paper\              SKILL.md + assets\template\<14 套赛事>\ + references\
├─ mathmodel-figure-templates\
├─ nature-figure\
├─ paper-diagram\
├─ paper-search\
├─ mma-review\  mma-figure\  metaheuristic-optimization\
├─ doctor\  data-search\  skill-creator\
└─ paper-sharing\          ← 建议删除
```

## 怎么用

| 目标运行时 | 做法 |
|---|---|
| DSH / Claude Code | 直接把技能目录放进其 skills 目录（格式本来就兼容） |
| Codex | 放进 Codex 认的 skills 目录，或包成 `.codex-plugin`（清单 + `skills/`）；再把 `AskUserQuestion`、`browser_*` 这类工具名替换掉 |
| 其他 Agent | 只有 `SKILL.md` 这一层是可移植的约定；不认的话就把 frontmatter 的 description 当触发条件、正文当提示词导入 |
