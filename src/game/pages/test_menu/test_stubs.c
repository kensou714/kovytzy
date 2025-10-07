/**
 * @file test_stubs.c
 * @brief 测试菜单功能桩函数
 *
 * 为所有测试菜单功能提供桩函数，调用ROM原函数
 * 未来可以逐个还原为完整的C实现
 */

#include <stdint.h>
#include "../../game_type.h"
#include "../../game_func.h"
#include "test_menu.h"

/* ============================================================================
 * ROM函数地址定义
 * ========================================================================= */

#define ROM_TEST_VOICE      0x001a1276UL
#define ROM_TEST_ROLE       0x001a1a50UL
#define ROM_TEST_RORO       0x001a24a2UL
#define ROM_TEST_OFFICER    0x001a2f68UL
#define ROM_TEST_SYSOBJ     0x001a3a2eUL
#define ROM_TEST_FOOD       0x001a17daUL
#define ROM_TEST_WEAPON     0x001a1944UL
#define ROM_TEST_CLEAR_RAM  0x001a3d30UL
#define ROM_TEST_SIGNATURE  0x001a3cc4UL
#define ROM_TEST_DIALOG     0x001a3f30UL
#define ROM_TEST_STORY      0x001a418eUL
#define ROM_TEST_OVER       0x001a4756UL
#define ROM_TEST_OVER1      0x001a47a0UL
#define ROM_TEST_RANK       0x001a47f0UL
#define ROM_TEST_ASIC27     0x001a488cUL

/* ============================================================================
 * 测试菜单桩函数实现
 * ========================================================================= */

/**
 * [ 1] TEST VOICE - 音效测试
 * 调用ROM原函数: 0x001a1276
 */
void test_voice(void)
{
    FUNC32(ROM_TEST_VOICE)();
}

/**
 * [ 2] TEST ROLE - 角色测试
 * 调用ROM原函数: 0x001a1a50
 */
void test_role(void)
{
    FUNC32(ROM_TEST_ROLE)();
}

/**
 * [ 3] TEST RORO - Roro对象测试
 * 调用ROM原函数: 0x001a24a2
 */
void test_roro(void)
{
    FUNC32(ROM_TEST_RORO)();
}

/**
 * [ 4] TEST OFFICER - 武将测试
 * 调用ROM原函数: 0x001a2f68
 */
void test_officer(void)
{
    FUNC32(ROM_TEST_OFFICER)();
}

/**
 * [ 5] TEST SYSOBJ - 系统对象测试
 * 调用ROM原函数: 0x001a3a2e
 */
void test_sysobj(void)
{
    FUNC32(ROM_TEST_SYSOBJ)();
}

/**
 * [ 6] TEST FOOD - 食物道具测试
 * 调用ROM原函数: 0x001a17da
 */
void test_food(void)
{
    FUNC32(ROM_TEST_FOOD)();
}

/**
 * [ 7] TEST WEAPON - 武器道具测试
 * 调用ROM原函数: 0x001a1944
 */
void test_weapon(void)
{
    FUNC32(ROM_TEST_WEAPON)();
}

/**
 * [ 8] CLEAR SYSTEM RAM - 清除系统RAM
 * 调用ROM原函数: 0x001a3d30
 */
void test_clear_ram(void)
{
    FUNC32(ROM_TEST_CLEAR_RAM)();
}

/**
 * [ 9] TEST SIGNATURE - 签名测试
 * 调用ROM原函数: 0x001a3cc4
 */
void test_signature(void)
{
    FUNC32(ROM_TEST_SIGNATURE)();
}

/**
 * [10] TEST DIALOG - 对话框测试
 * 调用ROM原函数: 0x001a3f30
 */
void test_dialog(void)
{
    FUNC32(ROM_TEST_DIALOG)();
}

/**
 * [11] TEST STORY - 剧情测试
 * 调用ROM原函数: 0x001a418e
 */
void test_story(void)
{
    FUNC32(ROM_TEST_STORY)();
}

/**
 * [12] TEST OVER - 游戏结束测试
 * 调用ROM原函数: 0x001a4756
 */
void test_over(void)
{
    FUNC32(ROM_TEST_OVER)();
}

/**
 * [13] TEST OVER1 - 游戏结束1测试
 * 调用ROM原函数: 0x001a47a0
 */
void test_over1(void)
{
    FUNC32(ROM_TEST_OVER1)();
}

/**
 * [14] TEST RANK - 排名测试
 * 调用ROM原函数: 0x001a47f0
 */
void test_rank(void)
{
    FUNC32(ROM_TEST_RANK)();
}

/**
 * [15] TEST ASIC27 - ASIC27保护芯片测试
 * 调用ROM原函数: 0x001a488c
 */
void test_asic27(void)
{
    FUNC32(ROM_TEST_ASIC27)();
}

/* ============================================================================
 * 还原指南
 * ========================================================================= */

/*
如何还原某个测试功能:

1. 从Ghidra获取反编译代码:
   curl 'http://172.18.160.1:8080/decompile_function?address=0x001aXXXX'

2. 创建独立的.c文件 (例如 test_voice.c):
   - 分析反编译代码
   - 实现功能逻辑
   - 处理全局变量（使用宏映射）
   - 处理外部函数调用（使用ROM桩）

3. 删除本文件中对应的桩函数

4. 在test_menu.h中保持函数声明不变

示例结构:
src/game/pages/test_menu/
├── test_menu.h       (统一头文件)
├── test_music.c      (已实现)
├── test_voice.c      (待实现)
├── test_role.c       (待实现)
├── ...
└── test_stubs.c      (本文件 - 逐步缩减)
*/
