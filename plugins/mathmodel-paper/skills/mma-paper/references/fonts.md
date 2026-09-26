# 字体下载与使用

按本届比赛要求核对字体名称及粗体、斜体；先检查当前模板自带文件和系统已有字体，缺什么补什么，不要静默换成其他字体。

- **宋体、黑体、楷体、仿宋**：可从第三方整理的 [latex-chinese-fonts](https://github.com/Haixing-Hu/latex-chinese-fonts) 下载。固定版本的原始文件链接：[SimSun.ttc](https://raw.githubusercontent.com/Haixing-Hu/latex-chinese-fonts/287399335ec1beb72062ce67c36eaa8bec35f386/chinese/%E5%AE%8B%E4%BD%93/SimSun.ttc)、[SimHei.ttf](https://raw.githubusercontent.com/Haixing-Hu/latex-chinese-fonts/287399335ec1beb72062ce67c36eaa8bec35f386/chinese/%E9%BB%91%E4%BD%93/SimHei.ttf)、[KaiTi.ttf](https://raw.githubusercontent.com/Haixing-Hu/latex-chinese-fonts/287399335ec1beb72062ce67c36eaa8bec35f386/chinese/%E6%A5%B7%E4%BD%93/Kaiti.ttf)、[FangSong.ttf](https://raw.githubusercontent.com/Haixing-Hu/latex-chinese-fonts/287399335ec1beb72062ce67c36eaa8bec35f386/chinese/%E4%BB%BF%E5%AE%8B%E4%BD%93/FangSong.ttf)。
- **Times New Roman、Arial、Courier New**：优先复用 Windows 的 `%WINDIR%\Fonts`；Mac 可检查已安装 Word 的 `Contents/Resources/DFonts/` 和 `/System/Library/Fonts/Supplemental/`。按实际需求同时取得常规、粗体、斜体、粗斜体文件，不要只凭文件名认定字体或把描粗当成独立粗体。
- **Ubuntu Mono（代码字体）**：从 [Ubuntu 官方字体包 0.83](https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip) 下载并解压，取所需的 `UbuntuMono-*.ttf`。
- **下载方法**：先创建当前论文项目的 `fonts/` 目录，再用 `curl -fL "<原始文件下载地址>" -o "fonts/<文件名>"`；Windows 使用 `curl.exe`。也可从 GitHub 文件页选择 **Download raw file**，不要把网页另存为字体。记录来源并检查字体内部名称、字形和文件完整性。
- **使用方法**：仅在当前论文项目中按 `.cls` / `.tex` 的加载方式接入字体；需要时用 `fontspec` / `xeCJK` 显式指定本地文件，例如 `\setCJKmainfont{SimSun.ttc}[Path=fonts/,FontIndex=0]`，绘图可用 `FontProperties(fname="fonts/SimSun.ttc")`。下载字体不代表模板已使用它；不要把下载文件写回本 Skill 的模板资源。
- 补齐后重新编译，检查日志中的字体缺失、字体替代和缺字提示；没有满足指定字体要求时，明确说明缺失项，不把“生成了 PDF”当作字体已合格。
