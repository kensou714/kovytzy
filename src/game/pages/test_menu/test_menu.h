/**
 * @file test_menu.h
 * @brief 测试菜单功能声明
 *
 * 包含主菜单中所有TEST功能的函数声明
 * 这些是调试/测试用的子页面功能
 */

#ifndef __TEST_MENU_H__
#define __TEST_MENU_H__

#ifdef __cplusplus
extern "C" {
#endif

/* ============================================================================
 * 测试菜单功能函数声明
 * ========================================================================= */

/**
 * [ 0] TEST MUSIC - 音乐测试
 * ROM地址: 0x001a1272 (数据，非函数)
 * 状态: 占位实现
 */
void test_music(void);

/**
 * [ 1] TEST VOICE - 音效测试
 * ROM地址: 0x001a1276
 * 状态: ROM原函数
 */
void test_voice(void);

/**
 * [ 2] TEST ROLE - 角色测试
 * ROM地址: 0x001a1a50
 * 状态: ROM原函数
 */
void test_role(void);

/**
 * [ 3] TEST RORO - Roro对象测试
 * ROM地址: 0x001a24a2
 * 状态: ROM原函数
 */
void test_roro(void);

/**
 * [ 4] TEST OFFICER - 武将测试
 * ROM地址: 0x001a2f68
 * 状态: ROM原函数
 */
void test_officer(void);

/**
 * [ 5] TEST SYSOBJ - 系统对象测试
 * ROM地址: 0x001a3a2e
 * 状态: ROM原函数
 */
void test_sysobj(void);

/**
 * [ 6] TEST FOOD - 食物道具测试
 * ROM地址: 0x001a17da
 * 状态: ROM原函数
 */
void test_food(void);

/**
 * [ 7] TEST WEAPON - 武器道具测试
 * ROM地址: 0x001a1944
 * 状态: ROM原函数
 */
void test_weapon(void);

/**
 * [ 8] CLEAR SYSTEM RAM - 清除系统RAM
 * ROM地址: 0x001a3d30
 * 状态: ROM原函数
 */
void test_clear_ram(void);

/**
 * [ 9] TEST SIGNATURE - 签名测试
 * ROM地址: 0x001a3cc4
 * 状态: ROM原函数
 */
void test_signature(void);

/**
 * [10] TEST DIALOG - 对话框测试
 * ROM地址: 0x001a3f30
 * 状态: ROM原函数
 */
void test_dialog(void);

/**
 * [11] TEST STORY - 剧情测试
 * ROM地址: 0x001a418e
 * 状态: ROM原函数
 */
void test_story(void);

/**
 * [12] TEST OVER - 游戏结束测试
 * ROM地址: 0x001a4756
 * 状态: ROM原函数
 */
void test_over(void);

/**
 * [13] TEST OVER1 - 游戏结束1测试
 * ROM地址: 0x001a47a0
 * 状态: ROM原函数
 */
void test_over1(void);

/**
 * [14] TEST RANK - 排名测试
 * ROM地址: 0x001a47f0
 * 状态: ROM原函数
 */
void test_rank(void);

/**
 * [15] TEST ASIC27 - ASIC27保护芯片测试
 * ROM地址: 0x001a488c
 * 状态: ROM原函数
 */
void test_asic27(void);

#ifdef __cplusplus
}
#endif

#endif /* __TEST_MENU_H__ */
