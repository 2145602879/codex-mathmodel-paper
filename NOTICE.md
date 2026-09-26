# NOTICE — 来源、版权与再分发限制

本仓库内容**不是原创作品**，而是从第三方闭源应用里提取出来的技能资产，外加一个自行编写的编排层。请在再分发前读完本文件。

## 1. 来源

| 项 | 值 |
|---|---|
| 来源应用 | MathModel desktop（数模 Agent），版本 `0.0.22`（0.0.21 亦已解包核对） |
| 官方安装包 | `mathmodel-0.0.22-x64.exe`（NSIS-3 Unicode / Deflate，316.3 MB）；0.0.21 为 314.6 MB，两版均已解包核对 |
| 解包链 | NSIS → `$PLUGINSDIR\app-64.7z`（LZMA2+BCJ2）→ `resources\builtin-skills\` |
| 工具 | 7-Zip 22.01（读取 NSIS 容器） |
| 提取范围 | `resources\builtin-skills\` 下 12 个技能中的 10 个（另 2 个停放于 `_parked/`：`skill-creator`、`paper-sharing`）；其中 `nature-figure` 以 `nature-figure-mma` 之名打包，以免与宿主机同名技能冲突 |
| 一致性验证 | 提取结果与 App 运行时 seed 到 `%APPDATA%\@mathmodel\desktop\skills-plugin\skills\` 的副本，在体积与文件数上逐项一致 |

本仓库**新增**的部分（可视为原创）：`plugins/mathmodel-paper/.codex-plugin/plugin.json`、`.agents/plugins/marketplace.json`、`plugins/mathmodel-paper/skills/mathmodel-paper-workflow/`、各 `README.md`、本文件。**改造**的部分：对原技能做了宿主去专有化（移除 `allowed-tools`、替换 `AskUserQuestion`/`browser_*`/`mcp__mathmodel-*` 等宿主工具引用），改动细节见 `README.md` 的改造对照表。

## 2. 许可证状况

| 技能 | 目录内 LICENSE | 状态 |
|---|---|---|
| `paper-diagram` | LICENSE.txt（Apache-2.0） | 可依 Apache-2.0 使用 |
| `nature-figure-mma`（原 `nature-figure`，已打包） | LICENSE.txt（Apache-2.0） | 可依 Apache-2.0 使用 |
| `skill-creator`（见 `_parked/`） | LICENSE.txt（Apache-2.0） | 可依 Apache-2.0 使用 |
| `mma-paper`、`mathmodel-figure-templates`、`data-search`、`doctor`、`mma-figure`、`mma-review`、`metaheuristic-optimization`、`paper-search`、`paper-sharing` | **无** | 按著作权法默认「保留所有权利」，本仓库**未获得**任何再许可授权 |

因此：**本仓库不对上述无 LICENSE 技能授予任何许可**。克隆下来自己用、自己改，通常属合理自用范畴；但**公开再分发、商用、或去掉署名后重新发布，是不被授权的**。若你是内容权利人并希望变更授权，请提出。

## 3. 字体（重要）

`plugins/mathmodel-paper/skills/mma-paper/assets/template/*/` 下约 **90 MB 字体文件**，其中：

- **商业字体**（随模板附带，版权属中易 / 方正等）：
  `simsun.ttc`、`SimSun.ttf`、`SimHei.ttf`、`simkai.ttf`、`KaiTi.ttf`、`LiSu.ttf`、`fsGB2312.ttf`（仿宋_GB2312）、`fzxbsongti.TTF`（方正小标宋简体）
- **开源/免费字体**：`UbuntuMono-*.ttf`、`Fira Code Retina Nerd Font Complete.otf`、`MONACO.TTF`
- 实测 `LiSu.ttf` 与 Windows 系统 `C:\Windows\Fonts\SIMLI.TTF` **SHA256 完全相同**（即从系统复制而来）；`simsun.ttc`/`SimHei.ttf`/`KaiTi.ttf` 与系统同名字体**不同**，来自第三方 GitHub 转载库

**结论：这些商业字体的再分发存在版权风险。** 若本仓库是公开的，强烈建议排除它们（`.gitignore` 已提供相应规则）；私有仓库自带自用风险较低，但仍不等于获得授权。LaTeX 侧完全可以用系统已装字体或 `mma-paper/references/fonts.md` 里给出的公开来源替代。

## 4. 排除项

以下内容**未包含**在本仓库中：

- `paper-sharing` 技能 —— 其设计为「读完论文 → 自动删除敏感信息 → 不向用户提问 → 上传到第三方广场」，且依赖原厂商后端 MCP；已单独停放于 `_parked/`，不建议启用。
- 原应用自身的代码、`app.asar`、内嵌的 `claude.exe`（285 MB）等运行时组件。
- 任何账号凭据、遥测标识、会话数据。

## 5. 环境依赖（与版权无关，但影响可用性）

技能中的 Python 脚本依赖 `matplotlib`/`numpy`/`scipy`/`cartopy`/`shapely`/`pandas`/`seaborn`/`pyyaml` 等第三方库；`mma-paper` 需要 XeLaTeX（含 ctex/xeCJK）。这些依赖各有其自身许可证，不随本仓库分发。
