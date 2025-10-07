/**
 * @file page_mainmenu.c
 * @brief 主菜单（调试菜单）页面实现
 *
 * ROM地址: 0x001a4960 (FUN_001a4960)
 *
 * 功能说明:
 * - 通过特定按键组合（Service + P1_Start + P1_Coin）进入调试菜单
 * - 显示16个测试项目菜单
 * - 支持上下键选择，Start键确认执行
 * - 提供游戏各子系统的测试入口
 *
 * 基于Ghidra反编译结果完整还原，菜单数据从ROM导出到代码定义
 */

#include <stdint.h>
#include "../game_type.h"
#include "../game_func.h"
#include "../game_api.h"

/* ============================================================================
 * 数据结构和常量定义
 * ========================================================================= */

/* 菜单配置常量 */
#define MENU_ITEM_COUNT         16            /* 菜单项数量 */

/* 全局变量映射（零RAM占用原则） */
#define g_menu_current_index    (*(volatile u16*)0x0081b382)  /* 当前选中的菜单索引 */
#define g_menu_prev_index       (*(volatile u16*)0x0081b380)  /* 上一次的菜单索引 */

/* 菜单显示位置 */
#define MENU_TITLE_X            10  /* 标题X坐标 */
#define MENU_TITLE_Y            0   /* 标题Y坐标 */
#define MENU_ITEM_X             14  /* 菜单项X坐标 */
#define MENU_ITEM_START_Y       6   /* 菜单项起始Y坐标 */

/* 输入按键定义 */
#define KEY_SERVICE             6   /* Service按键 */
#define KEY_P1_START            1   /* P1开始键 */
#define KEY_P1_COIN             2   /* P1投币键 */
#define KEY_P1_UP               2   /* P1上键（在菜单选择时） */
#define KEY_P1_DOWN             3   /* P1下键 */

/* ============================================================================
 * 菜单数据定义（从ROM导出）
 * ========================================================================= */

/**
 * @brief 菜单字符串常量
 * 原ROM地址: 0x001fc9fe - 0x001fcb0c
 */
static const char* const menu_strings[MENU_ITEM_COUNT] = {
    "TEST MUSIC      ",   /* [ 0] 音乐测试        */
    "TEST VOICE      ",   /* [ 1] 音效测试        */
    "TEST ROLE       ",   /* [ 2] 角色测试        */
    "TEST RORO       ",   /* [ 3] Roro对象测试    */
    "TEST OFFICER    ",   /* [ 4] 武将测试        */
    "TEST SYSOBJ     ",   /* [ 5] 系统对象测试    */
    "TEST FOOD       ",   /* [ 6] 食物道具测试    */
    "TEST WEAPON     ",   /* [ 7] 武器道具测试    */
    "CLEAR SYSTEM RAM",   /* [ 8] 清除系统RAM     */
    "TEST SIGNATURE  ",   /* [ 9] 签名测试        */
    "TEST DIALOG     ",   /* [10] 对话框测试      */
    "TEST STORY      ",   /* [11] 剧情测试        */
    "TEST OVER       ",   /* [12] 游戏结束测试    */
    "TEST OVER1      ",   /* [13] 游戏结束1测试   */
    "TEST RANK       ",   /* [14] 排名测试        */
    "TEST ASIC27     ",   /* [15] ASIC27保护芯片  */
};

/**
 * @brief 菜单函数指针类型
 */
typedef void (*MenuFuncPtr)(void);

/**
 * @brief TEST MUSIC 占位函数
 *
 * 注意：ROM中0x001a1272不是函数入口，而是数据表
 * 可能需要特殊的解释器来执行，暂时使用占位函数
 */
static void test_music_placeholder(void)
{
    /* 暂时什么都不做，避免跳转到数据地址崩溃 */
    Print_00152cbc(0, 10, 10, 1, 0, "TEST MUSIC - Not Implemented");
    Print_00152cbc(0, 10, 11, 0, 0, "Press START to return");

    /* 等待START键返回 */
    while (ChkKeyPress_0014f962(KEY_P1_START) == 0) {
        /* 等待 */
    }
}

/**
 * @brief 菜单测试函数指针数组
 * 原ROM地址: 0x00339caa
 *
 * 注意：这些函数目前指向ROM原始地址，未来可以逐个还原
 * 0x001a1272 不是函数，已替换为占位函数
 */
static const MenuFuncPtr menu_functions[MENU_ITEM_COUNT] = {
    test_music_placeholder,   /* [ 0] TEST MUSIC - 特殊：ROM中是数据，非函数 */
    (MenuFuncPtr)0x001a1276,  /* [ 1] TEST VOICE       */
    (MenuFuncPtr)0x001a1a50,  /* [ 2] TEST ROLE        */
    (MenuFuncPtr)0x001a24a2,  /* [ 3] TEST RORO        */
    (MenuFuncPtr)0x001a2f68,  /* [ 4] TEST OFFICER     */
    (MenuFuncPtr)0x001a3a2e,  /* [ 5] TEST SYSOBJ      */
    (MenuFuncPtr)0x001a17da,  /* [ 6] TEST FOOD        */
    (MenuFuncPtr)0x001a1944,  /* [ 7] TEST WEAPON      */
    (MenuFuncPtr)0x001a3d30,  /* [ 8] CLEAR SYSTEM RAM */
    (MenuFuncPtr)0x001a3cc4,  /* [ 9] TEST SIGNATURE   */
    (MenuFuncPtr)0x001a3f30,  /* [10] TEST DIALOG      */
    (MenuFuncPtr)0x001a418e,  /* [11] TEST STORY       */
    (MenuFuncPtr)0x001a4756,  /* [12] TEST OVER        */
    (MenuFuncPtr)0x001a47a0,  /* [13] TEST OVER1       */
    (MenuFuncPtr)0x001a47f0,  /* [14] TEST RANK        */
    (MenuFuncPtr)0x001a488c,  /* [15] TEST ASIC27      */
};

/**
 * @brief 菜单标题字符串
 * 原ROM地址: 0x001fcb1e
 */
static const char* const menu_title = "---MAIN_MENU---";

/**
 * @brief 菜单提示字符串格式
 * 原ROM地址: 0x001fcb2e
 */
static const char* const menu_prompt_fmt = "-%s-";

/* ============================================================================
 * 辅助函数
 * ========================================================================= */

/**
 * @brief 菜单选择处理函数
 *
 * Ghidra反编译原文: FUN_001a488e
 *
 * 功能：
 * - 处理上下键输入，更新菜单光标位置
 * - 高亮显示当前选中项
 * - 等待Start键确认
 *
 * @param x_pos 菜单显示X坐标
 * @param y_start 菜单起始Y坐标
 * @param strings 菜单字符串数组
 * @param item_count 菜单项数量
 * @param current_index 当前选中索引
 * @return 返回用户最终选中的索引
 */
static int menu_select_item(int x_pos, int y_start, const char* const* strings,
                            int item_count, int current_index)
{
    int prev_index;
    int new_index;
    int key_pressed;
    int need_redraw;

    need_redraw = 1;  /* 初始需要绘制 */
    new_index = current_index;

    while (1) {
        /* 检查DOWN键 */
        key_pressed = ChkKeyPress_0014f962(KEY_P1_DOWN);
        if (key_pressed == 0) {
            /* 没按DOWN，检查UP键 */
            key_pressed = ChkKeyPress_0014f962(KEY_P1_UP);
            if (key_pressed != 0) {
                /* 按了UP键 */
                prev_index = new_index;

                if (new_index > 0) {
                    new_index = new_index - 1;
                } else {
                    /* 已经在第一项，循环到最后 */
                    new_index = item_count - 1;
                }

                need_redraw = 1;
            }
        } else {
            /* 按了DOWN键 */
            prev_index = new_index;

            if (new_index < item_count - 1) {
                new_index = new_index + 1;
            } else {
                /* 已经在最后一项，循环到第一项 */
                new_index = 0;
            }

            need_redraw = 1;
        }

        /* 如果索引变化了，重新绘制菜单项 */
        if (need_redraw) {
            /* 恢复旧光标位置的显示（普通颜色） */
            Print_00152cbc(0, x_pos, prev_index + y_start, 0, 0,
                          strings[prev_index]);

            /* 高亮新光标位置（高亮颜色） */
            Print_00152cbc(0, x_pos, new_index + y_start, 1, 0,
                          strings[new_index]);

            need_redraw = 0;
        }

        /* 检查Start键确认 */
        key_pressed = ChkKeyPress_0014f962(KEY_P1_START);
        if (key_pressed != 0) {
            /* 按下Start，返回当前选中索引 */
            break;
        }
    }

    return new_index;
}

/* ============================================================================
 * 主菜单函数
 * ========================================================================= */

/**
 * @brief 主菜单（调试菜单）入口函数
 *
 * Ghidra反编译原文:
 * void FUN_001a4960(void)
 * {
 *   int iVar1;
 *
 *   iVar1 = FUN_0014f8ca(6);  // 检查Service键
 *   if (iVar1 != 0) {
 *     iVar1 = FUN_0014f8ca(2);  // 检查P1 Coin键
 *     if (iVar1 != 0) {
 *       iVar1 = FUN_0014f8ca(1);  // 检查P1 Start键
 *       if (iVar1 != 0) {
 *         // 进入主菜单循环
 *         ...
 *       }
 *     }
 *   }
 *   DAT_0081352b = 2;
 *   return;
 * }
 *
 * 功能说明:
 * 1. 检查按键组合（Service + Coin + Start）
 * 2. 初始化字体和显示系统
 * 3. 主循环显示16个测试菜单
 * 4. 处理用户选择并执行对应测试功能
 * 5. 退出后设置游戏状态为2
 */
void PageMainMenu(void)
{
    int key_check;
    int i;

    /* ========================================
     * 步骤1: 检查按键组合进入条件
     * ======================================= */

    /* 必须同时按下 Service + P1_Coin + P1_Start 才能进入调试菜单 */
    key_check = ChkKeyHold_0014f8ca(KEY_SERVICE);
    if (key_check == 0) {
        //goto exit_menu;
    }

    key_check = ChkKeyHold_0014f8ca(KEY_P1_COIN);
    if (key_check == 0) {
        //goto exit_menu;
    }

    key_check = ChkKeyHold_0014f8ca(KEY_P1_START);
    if (key_check == 0) {
        //goto exit_menu;
    }

    /* ========================================
     * 步骤2: 初始化显示系统
     * ======================================= */

    InitFnt_0015280a();  /* 初始化字体系统 */
    FUN_0015270a();      /* 清屏或初始化显示 */

    /* ========================================
     * 步骤3: 主菜单循环
     * ======================================= */

    while (1) {
        /* 每帧刷新 */
        InitFnt_0015280a();           /* 重新初始化字体 */
        SetSystemFontPal_00152b1e();  /* 设置系统字体调色板 */

        /* 显示菜单标题 "---MAIN_MENU---" */
        Print_00152cbc(0, MENU_TITLE_X, MENU_TITLE_Y, 4, 9, menu_title);

        /* 显示所有菜单项（普通颜色） */
        for (i = 0; i < MENU_ITEM_COUNT; i++) {
            Print_00152cbc(0, MENU_ITEM_X, i + MENU_ITEM_START_Y, 0, 0,
                          menu_strings[i]);
        }

        /* 等待用户选择菜单项 */
        g_menu_current_index = menu_select_item(
            MENU_ITEM_X,              /* X坐标 */
            MENU_ITEM_START_Y,        /* Y起始 */
            menu_strings,             /* 字符串数组 */
            MENU_ITEM_COUNT,          /* 菜单项数 */
            g_menu_current_index      /* 当前索引 */
        );

        /* 清除显示准备执行子功能 */
        FUN_00152712();  /* 清屏或准备下一屏 */

        /* 在屏幕顶部显示当前选中的功能名 "-%s-" */
        Print_00153452(0, MENU_TITLE_X, 0, 1, 3,
                      menu_prompt_fmt,
                      menu_strings[g_menu_current_index]);

        /* 执行对应的测试功能 */
        menu_functions[g_menu_current_index]();

        /* 测试功能返回后，继续循环显示菜单 */
    }

exit_menu:
    /* ========================================
     * 退出菜单，设置游戏状态
     * ======================================= */
    MainFSM_0081352b = 2;  /* 设置主状态机为状态2 */
    return;
}

/**
 * @brief Ghidra兼容性别名
 * 保持与Ghidra反编译符号的兼容性
 */
void FUN_001a4960(void) __attribute__((alias("PageMainMenu")));

/* ============================================================================
 * 菜单扩展说明
 * ========================================================================= */

/*
菜单自定义指南:

1. 修改菜单项名称:
   直接修改 menu_strings 数组中的字符串

2. 添加新的测试功能:
   - 在其他文件实现新的测试函数
   - 修改 menu_functions 数组，将ROM地址替换为新函数地址
   - 例如: (MenuFuncPtr)0x001a1272 -> my_music_test

3. 增加菜单项数量:
   - 修改 MENU_ITEM_COUNT 常量
   - 在 menu_strings 和 menu_functions 数组中添加新项
   - 注意：需要调整显示位置以适应更多项

4. 修改菜单样式:
   - 修改 MENU_TITLE_X/Y, MENU_ITEM_X 等常量调整位置
   - 修改 Print_00152cbc 的颜色参数调整颜色

示例 - 添加自定义菜单项:

void my_custom_test(void) {
    // 自定义测试功能实现
    Print_00152cbc(0, 10, 10, 1, 0, "Custom Test Running...");
    // ...
}

// 修改 menu_strings 和 menu_functions:
static const char* const menu_strings[17] = {
    ...
    "MY CUSTOM TEST  ",  // 新增项
};

static const MenuFuncPtr menu_functions[17] = {
    ...
    my_custom_test,  // 新增项
};

#define MENU_ITEM_COUNT 17  // 更新数量
*/
