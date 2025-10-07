# Game 源码目录结构

本目录包含游戏代码还原后的C源文件，按功能模块组织。

## 目录结构

```
game/
├── common/          # 公共定义和全局变量

│
├── core/            # 核心游戏逻辑

│
├── ui/              # 用户界面和菜单

│
├── player/          # 玩家相关功能

│
├── system/          # 系统级功能

│
└── utils/           # 工具函数

```

## 使用指南

### 包含头文件顺序

推荐的头文件包含顺序：

```c
// 1. 标准库头文件
#include <stdint.h>

// 2. 公共定义
#include "../common/types.h"
#include "../common/globals.h"

// 3. 本模块头文件
#include "core.h"  // 或其他模块头文件

// 4. 其他模块头文件（按需）
#include "../utils/utils.h"
#include "../player/player.h"
// ...
```

### 全局变量使用

所有全局变量都定义在 `common/globals.h` 中，使用宏映射到ROM原地址：

```c
#include "../common/globals.h"

void my_function(void) {
    // 直接使用全局变量，无需再定义
    g_game_state = 0;
    if (g_boot_type == 1) {
        // ...
    }
}
```

### 调用其他模块函数

```c
#include "../utils/utils.h"

void my_function(void) {
    // 调用工具函数
    u8 region = get_region_code();
    check_button_pressed(1);
}
```

### ROM函数调用

如果需要调用尚未还原的ROM函数，使用 `rom_call.h` 中的宏：

```c
#include "../common/rom_call.h"

void my_function(void) {
    // 无参数调用
    CALL_ROM(0x001234);

    // 有参数调用
    CALL_ROM_2ARG(0x005678, arg1, arg2);

    // 有返回值
    int result = CALL_ROM_RET(0x009abc, int);
}
```

## 模块说明

### common - 公共定义
- 包含全局变量、类型定义、ROM调用辅助等
- 被所有其他模块引用

### core - 核心逻辑
- 游戏的启动、初始化、主循环
- 状态机管理
- 核心游戏逻辑

### ui - 用户界面
- 菜单系统
- 警告和提示显示
- 图形资源管理

### player - 玩家管理
- 玩家数据管理
- 投币和游戏币处理
- 玩家状态检查

### system - 系统功能
- 服务模式
- 输入系统
- 系统级配置

### utils - 工具函数
- 输入检测
- 文本显示
- 字符串处理
- 配置读取
- 通用工具

## 代码规范

1. **零RAM占用原则**：所有全局变量必须使用宏映射到ROM原地址
2. **兼容性别名**：所有函数都提供Ghidra原始符号的别名
3. **中文注释**：代码注释使用中文，包含Ghidra反编译原文
4. **文件编码**：UTF-8
5. **头文件保护**：使用 `#ifndef/#define/#endif`

## 待办事项

