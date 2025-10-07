
#include "xxpacth_include.h"
.section .patch,"ax"

XXEXPORT_START(dumpy)

.file "src/patch/hook_MainInit.S"
.line 0
//warning界面函数

.file "src/patch/hook_bosshpbar.S"
.line 0
 //BOSS血条


.file "src/patch/hook_door.S"
.line 0

.file "src/patch/hook_screenupdate.S"
.line 0

.file "src/patch/patch_checksum.S"
.line 0

//FUN_0019a6e8

.file "src/patch/patch_dropitem.S"
.line 0

//hook基本按键 增加BC键扔道具
//$$PATCH16JMP16(0x7d81c,ChkPlayerInput)

.file "src/patch/patch_scoretable.S"
.line 0
//外置A面人物分数表

.file "src/patch/patch_stagetable.S"
.line 0

//关卡总表PATCH

.file "src/patch/patch_testF0.S"
.line 0

.file "src/patch/patch_testdoor.S"
.line 0
//第一关出场刷兵脚本调用门测试

.file "src/patch/hook_bosshpbar.S"
.line 5
	XXPATCH16JMP16(0x55c18,DrawBossInfo)

.file "src/patch/patch_checksum.S"
.line 9
	XXPATCH16(0x61E7C) .word 0x7200;

//FUN_0014eb66

.file "src/patch/patch_checksum.S"
.line 66
	XXPATCH16(0x6221A) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 65
	XXPATCH16(0x623B0) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 84
	XXPATCH16(0x626C4) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 74
	XXPATCH16(0x62926) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 73
	XXPATCH16(0x62B8C) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 170
	XXPATCH16(0x62D08) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 8
	XXPATCH16(0x62F34) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 99
	XXPATCH16(0x63084) .word 0x7200;

//FUN_001a6b8c 触发跳回上一关

.file "src/patch/patch_checksum.S"
.line 126
	XXPATCH16(0x63150) .word 0x7200;

//0x81b24a 无敌小兵

.file "src/patch/patch_scoretable.S"
.line 3
	XXPATCH16PTR16(0x663ce,ScoreTblB)
.file "src/patch/patch_scoretable.S"
.line 1
	XXPATCH16PTR16(0x66400,ScoreTblA)
//外置B面人物分数表

.file "src/patch/patch_dropitem.S"
.line 8
	XXPATCH16(0x69c7c) .word 0x2f0b;

.file "src/patch/patch_dropitem.S"
.line 9
	XXPATCH16(0x69c80) jsr EatItem;

.file "src/patch/patch_dropitem.S"
.line 10
	XXPATCH16(0x69c9a) .word 0x2f0b;

.file "src/patch/patch_dropitem.S"
.line 11
	XXPATCH16(0x69c9e) jsr EatItem;



 

.file "src/patch/patch_checksum.S"
.line 13
	XXPATCH16(0x6CA36) .word 0x7200;

//FUN_0014e720

.file "src/patch/hook_door.S"
.line 2
	XXPATCH16JMP16(0x79bac,api_setdoor)

.file "src/patch/hook_door.S"
.line 3
	XXPATCH16JMP16(0x79c70,api_clrdoor)
.file "src/patch/hook_door.S"
.line 1
	XXPATCH16JMP16(0x79c88,api_clralldoor)

.file "src/patch/hook_door.S"
.line 0
	XXPATCH16JMP16(0x79ca4,api_chkdoor)

.file "src/patch/patch_dropitem.S"
.line 4
	XXPATCH16(0x7dd54) jsr ChkMove;

//$$PATCH16JMP16(0x60d10,hook_eatitem)
//hook道具拾取时候的判断，根据扔出道具的数量来拾取

.file "src/patch/patch_dropitem.S"
.line 3
	XXPATCH16(0x7df2a) jsr ChkMove;

.file "src/patch/patch_checksum.S"
.line 125
	XXPATCH16(0x83E92) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 115
	XXPATCH16(0x85134) .word 0x7200;

//0x812e24=1

.file "src/patch/patch_checksum.S"
.line 124
	XXPATCH16(0x85C16) .word 0x7200;

.file "src/patch/hook_screenupdate.S"
.line 0
	XXPATCH16JMP16(0x8c492,ScreenUpdate)
.file "src/patch/patch_checksum.S"
.line 114
	XXPATCH16(0x8D116) .word 0x7200;

.file "src/patch/hook_bosshpbar.S"
.line 6
	XXPATCH16JMP16(0x8f230,ClearBossInfo)

//BOSS撞物 扩大BOSS上限到3

.file "src/patch/hook_bosshpbar.S"
.line 2
	XXPATCH16JMP16(0x8fabe,ChangeBossHP)

.file "src/patch/hook_bosshpbar.S"
.line 3
	XXPATCH16JMP16(0x8fafc,ChangeBossHpBar)

.file "src/patch/hook_bosshpbar.S"
.line 4
	XXPATCH16JMP16(0x8fbb4,ChkBossHP)

.file "src/patch/patch_checksum.S"
.line 38
	XXPATCH16(0x91C04) .word 0x7200;

//FUN_00151204

.file "src/patch/hook_bosshpbar.S"
.line 9
	XXPATCH16(0x96474) .word 0x7203;



.file "src/patch/patch_checksum.S"
.line 23
	XXPATCH16(0x96F86) .word 0x7200;

//FUN_0015205e

.file "src/patch/patch_checksum.S"
.line 4
	XXPATCH16(0x973D2) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 3
	XXPATCH16(0x97444) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 7
	XXPATCH16(0x98744) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 2
	XXPATCH16(0x987B2) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 6
	XXPATCH16(0x98824) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 12
	XXPATCH16(0x98C4A) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 16
	XXPATCH16(0x98FA8) .word 0x7200;

//FUN_0014be5e

.file "src/patch/patch_checksum.S"
.line 64
	XXPATCH16(0x9924E) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 83
	XXPATCH16(0x9BDDC) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 122
	XXPATCH16(0x9CC4C) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 121
	XXPATCH16(0x9D804) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 63
	XXPATCH16(0x9D9BC) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 98
	XXPATCH16(0x9EEAA) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 169
	XXPATCH16(0x9F728) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 72
	XXPATCH16(0x9FC1E) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 42
	XXPATCH16(0xA0698) .word 0x7200;

//FUN_00154832

.file "src/patch/patch_checksum.S"
.line 71
	XXPATCH16(0xA0852) .word 0x7200;

.file "src/patch/hook_MainInit.S"
.line 1
	XXPATCH16JMP16(0xa0f12,PageMainMenu)
//$$PATCH16JMP16(0xa4b12,0x1a4b6c)




//titlepage界面函数
//$$PATCH16JMP16(0x98f36,TitlePage)

//CopyRight界面
//$$PATCH16(0x8d0fe) jsr NewCopyRight;
.file "src/patch/patch_checksum.S"
.line 19
	XXPATCH16(0xA0F62) .word 0x7200;

//FUN_00152a72

.file "src/patch/patch_checksum.S"
.line 27
	XXPATCH16(0xA4D80) .word 0x7200;

//FUN_0014ea5c

.file "src/patch/patch_checksum.S"
.line 120
	XXPATCH16(0xA543E) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 34
	XXPATCH16(0xA5674) .word 0x7200;

//FUN_0014e7d4

.file "src/patch/patch_stagetable.S"
.line 2
	XXPATCH16PTR32(0xa58b6,StageTbl)

.file "src/patch/patch_stagetable.S"
.line 3
	XXPATCH16PTR32(0xa5be0,StageTbl)

.file "src/patch/patch_stagetable.S"
.line 4
	XXPATCH16PTR32(0xa62da,StageTbl)

.file "src/patch/patch_stagetable.S"
.line 5
	XXPATCH16PTR32(0xa65e2,StageTbl+4)

.file "src/patch/patch_stagetable.S"
.line 6
	XXPATCH16PTR32(0xa6600,StageTbl+4)

.file "src/patch/patch_stagetable.S"
.line 7
	XXPATCH16PTR32(0xa6994,StageTbl+28)

.file "src/patch/patch_checksum.S"
.line 153
	XXPATCH16(0xB176C) .word 0x7200;

//0x80df92=1 触发游戏时间变为13

.file "src/patch/patch_checksum.S"
.line 92
	XXPATCH16(0xB2704) .word 0x7200;

//0x812cdc=1

.file "src/patch/patch_checksum.S"
.line 150
	XXPATCH16(0xB3090) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 62
	XXPATCH16(0xB3682) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 149
	XXPATCH16(0xB3D22) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 123
	XXPATCH16(0xB40B8) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 139
	XXPATCH16(0xB521E) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 22
	XXPATCH16(0xB5D82) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 97
	XXPATCH16(0xB63E0) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 26
	XXPATCH16(0xB6730) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 30
	XXPATCH16(0xB77CC) .word 0x7200;

//FUN_0014de1e

.file "src/patch/patch_checksum.S"
.line 33
	XXPATCH16(0xB7D56) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 138
	XXPATCH16(0xB7E06) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 130
	XXPATCH16(0xB8190) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 137
	XXPATCH16(0xB8924) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 113
	XXPATCH16(0xB8BFC) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 37
	XXPATCH16(0xB922A) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 41
	XXPATCH16(0xB941C) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 164
	XXPATCH16(0xBA1D4) .word 0x7200;

//0x81b27a=1 

.file "src/patch/patch_checksum.S"
.line 91
	XXPATCH16(0xBC988) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 163
	XXPATCH16(0xBD7B6) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 140
	XXPATCH16(0xBEC38) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 141
	XXPATCH16(0xC1212) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 45
	XXPATCH16(0xC1B12) .word 0x7200;

//FUN_0016949e

.file "src/patch/patch_checksum.S"
.line 90
	XXPATCH16(0xC4D08) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 162
	XXPATCH16(0xC5202) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 107
	XXPATCH16(0xC5890) .word 0x7200;

//FUN_001988fa

.file "src/patch/patch_checksum.S"
.line 48
	XXPATCH16(0xC5CFE) .word 0x7200;

//FUN_001540e2

.file "src/patch/patch_checksum.S"
.line 67
	XXPATCH16(0xC6440) .word 0x7200;

//0x80cf06=1

.file "src/patch/patch_checksum.S"
.line 85
	XXPATCH16(0xC7E0A) .word 0x7200;

//0x81b3ea=1

.file "src/patch/patch_checksum.S"
.line 96
	XXPATCH16(0xC9938) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 136
	XXPATCH16(0xCA2F0) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 135
	XXPATCH16(0xCBA9E) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 172
	XXPATCH16(0xCBF5A) .word 0x7200;


.file "src/patch/patch_checksum.S"
.line 142
	XXPATCH16(0xCE4E0) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 134
	XXPATCH16(0xD3EA4) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 143
	XXPATCH16(0xD5124) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 75
	XXPATCH16(0xD6098) .word 0x7200;

//FUN_00150eb8

.file "src/patch/patch_checksum.S"
.line 171
	XXPATCH16(0xD656E) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 82
	XXPATCH16(0xD91E2) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 51
	XXPATCH16(0xDA31C) .word 0x7200;

//FUN_0014b9d4

.file "src/patch/patch_checksum.S"
.line 144
	XXPATCH16(0xDAE40) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 61
	XXPATCH16(0xDD704) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 54
	XXPATCH16(0xDD79E) .word 0x7200;

//FUN_0014fa28

.file "src/patch/patch_checksum.S"
.line 145
	XXPATCH16(0xDE404) .word 0x0000;

//FUN_0016dfc2

.file "src/patch/patch_checksum.S"
.line 89
	XXPATCH16(0xDE760) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 57
	XXPATCH16(0xDF7C8) .word 0x7200;

//0x80e316=1

.file "src/patch/patch_checksum.S"
.line 60
	XXPATCH16(0xE0380) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 70
	XXPATCH16(0xE0760) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 106
	XXPATCH16(0xE0962) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 105
	XXPATCH16(0xE09DE) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 112
	XXPATCH16(0xE0DAC) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 152
	XXPATCH16(0xE0E8E) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 78
	XXPATCH16(0xE0FB6) .word 0x7200;

//0x80ba92=1

.file "src/patch/patch_checksum.S"
.line 81
	XXPATCH16(0xE2094) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 111
	XXPATCH16(0xE238E) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 161
	XXPATCH16(0xE2994) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 160
	XXPATCH16(0xE2B00) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 159
	XXPATCH16(0xE37E4) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 158
	XXPATCH16(0xE54C2) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 88
	XXPATCH16(0xE6746) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 157
	XXPATCH16(0xE7238) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 119
	XXPATCH16(0xE8FC8) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 104
	XXPATCH16(0xE94E8) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 133
	XXPATCH16(0xE9AC6) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 103
	XXPATCH16(0xEA552) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 95
	XXPATCH16(0xEB118) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 151
	XXPATCH16(0xEB1B8) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 102
	XXPATCH16(0xEB2CA) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 168
	XXPATCH16(0xEC60A) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 110
	XXPATCH16(0xED14A) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 132
	XXPATCH16(0xED3FA) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 118
	XXPATCH16(0xED782) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 131
	XXPATCH16(0xEE058) .word 0x0000;

.file "src/patch/patch_checksum.S"
.line 129
	XXPATCH16(0xEF9CA) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 148
	XXPATCH16(0xEFCAC) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 156
	XXPATCH16(0xEFD14) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 167
	XXPATCH16(0xF0E76) .word 0x7200;

.file "src/patch/patch_checksum.S"
.line 5
	XXPATCH16(0xF7164) .word 0x7200;

.file "src/patch/patch_testF0.S"
.line 0
	XXPATCH16(0x28233e)

.byte 0xF0,0x46,0x02,0x00|敌人被打动作设定 byte_1=被打类型 byte_2=被打硬直
.byte 0xF0,0x0B,0xDC,0x00,0x01,0x6D,0x00,0x00|播放音效 byte_1=音量 byte_2=0 word_3=音效ID word_5=0
.byte 0xF0,0x02,0x04,0x00|设置帧率 byte_1=帧率 byte_2=0 
.byte 0x00,0xD2,0x00,0x00|显示图片 word_1=图片ID byte_3=X移动 byte_4=0
.byte 0xF0,0x02,0x02,0x00
.byte 0x00,0xD3,0x00,0x00

.byte 0x80,0x00,0x00,0x00




.byte 0xF0,0x13,0x00,0x00
.byte 0xF0,0x14,0x00,0x04,0x00,0x00,0x01,0x00
.byte 0xF0,0x33,0x01,0x00
.byte 0xF0,0x34,0x00,0xFF,0x00,0xDF,0x00,0x00,0x00,0x00,0x00,0xF4,0x20,0xD4,0x00,0xF4
.byte 0xF0,0x34,0x00,0xFF,0x00,0xDF,0x00,0x00,0x00,0x00,0x00,0xF6,0x20,0xD4,0x00,0xF6
.byte 0xF0,0x49,0x00,0x00
.byte 0xF0,0x34,0x00,0xFF,0x00,0xE0,0x00,0x00,0x00,0x00,0x00,0xF8,0x20,0xD5,0x00,0xF8
.byte 0xF0,0x34,0x00,0xFF,0x00,0xE0,0x00,0x00,0x00,0x00,0x00,0xFA,0x20,0xD5,0x00,0xFA
.byte 0xF0,0x33,0x00,0x00
.byte 0xF0,0x02,0x03,0x00,0x00,0xD6,0x00,0xFC
.byte 0xF0,0x0E,0x00,0x00
.byte 0xF0,0x02,0x02,0x00,0x20,0xD7,0x00,0x04
.byte 0xF0,0x33,0x01,0x00
.byte 0xF0,0x1B,0x2D,0x00
.byte 0xF0,0x34,0x00,0xFF,0x00,0xDB,0x00,0x00,0x00,0x00,0x00,0x0A,0x20,0xD7,0x00,0x0C
.byte 0xF0,0x34,0x00,0xFF,0x00,0xDC,0x00,0x00,0x00,0x00,0x00,0x00,0x20,0xD8,0x00,0x0C
.byte 0xF0,0x01,0x28,0x00
.file "src/patch/patch_testdoor.S"
.line 11
	XXPATCH16(0x2cefe6)
.byte	0xFF,0x14,0x00,0x00;|
.byte	0xFF,0x11,0x03,0x00;|设置AI
.byte	0xFF,0x04,0x03,0x01,0x00,0x13,0x05,0x84,0x02,0x5D,0x00,0xF6,0x00,0x00,0x00,0x01;|刷一只弓箭手
.byte	0xFF,0x08,0x00,0x00;|循环判断场上小兵剩余0
.byte	0xFF,0x0c,0x01,0x01;|门的ID和门坐标ID
.long	SetDoorByID;|调用函数
.byte	0xff,0x16,0x00,0x00;|刷兵脚本结束

.file "src/patch/patch_testdoor.S"
.line 1
	XXPATCH16(0x2cf530)
.byte	0xFF,0x14,0x00,0x00;|
.byte	0xFF,0x11,0x03,0x00;|设置AI
.byte	0xFF,0x04,0x03,0x01,0x00,0x13,0x05,0x84,0x02,0x5D,0x00,0xF6,0x00,0x00,0x00,0x01;|刷一只弓箭手
.byte	0xFF,0x08,0x00,0x00;|循环判断场上小兵剩余0
.byte	0xFF,0x0c,0x01,0x00;|门的ID和门坐标ID
.long	SetDoorByID;|调用函数
.byte	0xff,0x16,0x00,0x00;|刷兵脚本结束

//第一关第四场景调用门测试

.file __FILE__
.line __LINE__
XXEXPORT_END(dumpy)
.org 0x380000
XXEXPORT_START(ccode)
