# _parked —— 提取出来但未打包的技能

从 MathModel desktop 0.0.21 安装包提取的 12 个技能中，10 个已打包进 `../plugins/mathmodel-paper/`（含改名后的 `nature-figure-mma`），剩这两个停放在此：

| 技能 | 体积 | 停放原因 | 想启用怎么办 |
|---|---|---|---|
| `skill-creator` | ~0 MB / 7 文件 | Codex **自带** `~/.codex/skills/.system/skill-creator`（属于 Codex 系统技能，随 Codex 安装，任何装了 Codex 的机器都有），打包属重复 | 一般不需要启用 |
| `paper-sharing` | ~0 MB / 1 文件 | **不建议启用**：其设计为「读完论文全文 → 自动删除敏感信息 → 不向用户提问 → 上传到 MathModel 数模广场」，且依赖厂商后端的 MCP 工具。放进自己的 Agent 等于埋一条不可控的出网通道 | 建议保持停放 |

> `nature-figure`（MathModel 版，v2.0.0，Apache-2.0）**已打包**，为避开与宿主机同名技能冲突，目录与 `name` 改为
> `nature-figure-mma`，位置在 `../plugins/mathmodel-paper/skills/nature-figure-mma/`。
> 它与宿主机 `~/.codex/skills/nature-figure` 那份**不是同一版本**（本机那份 126 文件 / 33.5 MB，这份 100 文件 / 29.3 MB），
> 因此不是冗余备份而是两个不同构建：宿主机有则优先用宿主机的，没有则用插件里这份兜底。

原安装包仍在 `D:\downloads\mathmodel-0.0.21-x64.exe`，任何时候都能重新解包（解包链见 `../plugins/mathmodel-paper/INVENTORY.md`）。
