
#include "xxpacth_include.h"
.section .patch,"ax"

XXEXPORT_START(dumpy)

.file "src/patch/test_patch.S"
.line 0
//测试
	
.file "src/patch/test_patch.S"
.line 1
	XXPATCH16(0x231)
		.asciz "HAI"
.file __FILE__
.line __LINE__
XXEXPORT_END(dumpy)
.org 0x380000
XXEXPORT_START(ccode)
