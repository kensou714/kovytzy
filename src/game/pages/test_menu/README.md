# Test Menu 测试菜单功能目录

## 目录说明

本目录包含主菜单中所有TEST功能的实现代码。这些是游戏的调试/测试子页面。

## 文件结构

```
test_menu/
├── README.md          # 本文档
├── test_menu.h        # 统一头文件，声明所有测试功能
├── test_music.c       # [ 0] TEST MUSIC - 音乐测试（占位实现）
└── test_stubs.c       # [1-15] 其他测试功能的桩函数
```

## 测试功能列表

| 索引 | 功能名称 | ROM地址 | 实现状态 | 源文件 |
|------|----------|---------|----------|--------|
| 0 | TEST MUSIC | 0x001a1272* | 占位实现 | test_music.c |
| 1 | TEST VOICE | 0x001a1276 | ROM桩 | test_stubs.c |
| 2 | TEST ROLE | 0x001a1a50 | ROM桩 | test_stubs.c |
| 3 | TEST RORO | 0x001a24a2 | ROM桩 | test_stubs.c |
| 4 | TEST OFFICER | 0x001a2f68 | ROM桩 | test_stubs.c |
| 5 | TEST SYSOBJ | 0x001a3a2e | ROM桩 | test_stubs.c |
| 6 | TEST FOOD | 0x001a17da | ROM桩 | test_stubs.c |
| 7 | TEST WEAPON | 0x001a1944 | ROM桩 | test_stubs.c |
| 8 | CLEAR SYSTEM RAM | 0x001a3d30 | ROM桩 | test_stubs.c |
| 9 | TEST SIGNATURE | 0x001a3cc4 | ROM桩 | test_stubs.c |
| 10 | TEST DIALOG | 0x001a3f30 | ROM桩 | test_stubs.c |
| 11 | TEST STORY | 0x001a418e | ROM桩 | test_stubs.c |
| 12 | TEST OVER | 0x001a4756 | ROM桩 | test_stubs.c |
| 13 | TEST OVER1 | 0x001a47a0 | ROM桩 | test_stubs.c |
| 14 | TEST RANK | 0x001a47f0 | ROM桩 | test_stubs.c |
| 15 | TEST ASIC27 | 0x001a488c | ROM桩 | test_stubs.c |

\* 注：0x001a1272是数据地址而非函数，详见`test/MAINMENU_ISSUE_TESTMUSIC.md`

## 如何添加/还原测试功能

### 方法1：创建新的测试功能

1. **创建新文件**：例如 `test_voice.c`

2. **实现功能**：
```c
#include "../../game_type.h"
#include "../../game_func.h"
#include "test_menu.h"

void test_voice(void)
{
    // 你的实现代码
    InitFnt_0015280a();
    FUN_0015270a();

    // 显示界面
    Print_00152cbc(0, 10, 10, 1, 0, "TEST VOICE");

    // 功能逻辑...

    // 等待退出
    while (ChkKeyPress_0014f962(1) == 0) { }
}
```

3. **从test_stubs.c中删除对应的桩函数**

4. **编译测试**：CMake会自动包含新文件

### 方法2：从ROM还原现有功能

1. **获取Ghidra反编译代码**：
```bash
curl 'http://172.18.160.1:8080/decompile_function?address=0x001a1276'
```

2. **创建新文件**：参照反编译代码实现

3. **处理细节**：
   - 全局变量：使用宏映射（零RAM占用）
   - 外部函数：使用`FUNC32()`调用ROM函数
   - 数据引用：直接使用ROM地址

4. **测试验证**：在模拟器中运行测试

## 代码规范

### 文件命名
- 使用小写+下划线：`test_xxx.c`
- 一个功能一个文件

### 函数命名
- 与头文件声明保持一致
- 格式：`test_xxx(void)`

### 注释要求
```c
/**
 * @file test_xxx.c
 * @brief TEST XXX - 功能说明
 *
 * ROM地址: 0x001aXXXX
 * 状态: 完全还原/部分还原/占位实现
 */
```

### 头文件包含顺序
```c
#include <stdint.h>           // 标准库
#include "../../game_type.h"  // 游戏类型
#include "../../game_func.h"  // 游戏函数
#include "test_menu.h"        // 测试菜单
```

## 调试技巧

### 1. 显示调试信息
```c
Print_00152cbc(0, 10, 10, 1, 0, "Debug: Value = %d", value);
```

### 2. 等待按键
```c
while (ChkKeyPress_0014f962(1) == 0) {
    /* 等待START键 */
}
```

### 3. 调用ROM原函数
```c
#define ROM_FUNCTION_ADDR 0x001aXXXX
FUNC32(ROM_FUNCTION_ADDR)(param1, param2);
```

### 4. 访问全局变量
```c
// 零RAM占用方式
#define g_some_var (*(volatile u16*)0x00XXXXXX)
g_some_var = 100;
```

## 常见问题

### Q: 如何知道某个功能需要哪些参数？
A: 查看Ghidra反编译代码中的函数签名，或者分析ROM中的调用处。

### Q: 全局变量地址怎么找？
A: 在Ghidra中查看函数引用的数据地址，使用宏映射到对应RAM地址。

### Q: 可以混用ROM函数和自己的实现吗？
A: 可以！使用`FUNC32()`调用ROM函数，逐步替换为自己的实现。

### Q: 测试功能可以互相调用吗？
A: 可以，在`test_menu.h`中声明即可相互调用。

## 相关文档

- **主菜单实现**：`../page_mainmenu.c`
- **TEST MUSIC问题**：`test/MAINMENU_ISSUE_TESTMUSIC.md`
- **还原总结**：`test/MAINMENU_RESTORATION_SUMMARY.md`
- **快速参考**：`test/MAINMENU_QUICK_REF.md`

## 未来计划

### 短期目标
- [ ] 还原 TEST VOICE（音效测试）
- [ ] 还原 TEST ROLE（角色测试）
- [ ] 还原 TEST FOOD（道具测试）

### 中期目标
- [ ] 完整还原所有16个测试功能
- [ ] 添加自定义测试功能
- [ ] 优化用户界面

### 长期目标
- [ ] 创建可重用的测试框架
- [ ] 支持运行时配置
- [ ] 提供MOD接口

## 贡献指南

如果你还原了某个测试功能，请：
1. 确保代码遵循规范
2. 添加详细注释
3. 测试功能完整性
4. 更新本README的功能列表

---

**维护者**：项目团队
**最后更新**：2025-10-07
