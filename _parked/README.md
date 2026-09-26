# _parked —— 提取出来但未打包的技能

这三个都是从 MathModel desktop 0.0.21 安装包里提取出来的，出于以下原因没有放进插件：

| 技能 | 体积 | 停放原因 | 想启用怎么办 |
|---|---|---|---|
| `nature-figure` | 29.3 MB / 100 文件 | 你已有一份 **Codex 原生版**（`~/.codex/skills/nature-figure`，126 文件 / 33.5 MB），两者**不是同一版本**；重复打包会造成同名技能冲突和 29 MB 冗余 | 直接 `Move-Item` 到 `../plugins/mathmodel-paper/skills/` 即可；或先对比两份再决定用哪个 |
| `skill-creator` | ~0 MB / 7 文件 | Codex 自带 `~/.codex/skills/.system/skill-creator`，功能重复 | 一般不需要启用 |
| `paper-sharing` | ~0 MB / 1 文件 | **不建议启用**：其设计为「读完论文全文 → 自动删除敏感信息 → 不向用户提问 → 上传到 MathModel 数模广场」，且依赖厂商后端的 MCP 工具。放进自己的 Agent 等于埋一条不可控的出网通道 | 建议保持停放 |

原安装包仍在 `D:\downloads\mathmodel-0.0.21-x64.exe`，任何时候都能重新解包（解包链见 `../plugins/mathmodel-paper/INVENTORY.md`）。
