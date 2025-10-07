## 文件编码
- 如果没有特殊要求，文件编码统一使用UTF-8

## 代码注释
- 如果没有特殊要求，所有代码的注释统一使用中文

## python命令
- python的执行名叫python而不是python3

## 框架的使用方法
  - CMakeLists.txt:4 通过 file(GLOB_RECURSE) 自动收集 src/*.c 与 src/*.S，配置 game 目标并在构建时先触发        
  generate_patch，因此只需把新增源码/补丁文件放到 src 下即可。
  - CMakeLists.txt:18 定义的自定义命令会调用 python gen_patch.py 把 src/patch/*.S 合并成 src/patch.S，在链接前把
  所有补丁整理到 .patch 段。
  - CMakeLists.txt:31 的 apply_patch(game) 在生成 ELF 后执行 python app_patch.py，借助交叉工具链的 objcopy      
  把 .rom/.ram 段内容写回基准 ROM，得到成品 ytzy_v201cn_h.rom。
  - pgm.cmake:22 设定交叉编译前缀、ROM 输入输出文件和 ROM_OFFSET，配置好 TC_PATH 或直接修改这里，就能用 cmake ..  -DCMAKE_TOOLCHAIN_FILE=../pgm.cmake 配置并用 cmake --build . 交叉编译。
  - README.md:18 给出了标准流程：准备 m68k-elf 工具链、Python3 和 CMake，创建 build 目录后运行配置与构建命令    
  即可。

## src目录说明

  - src/xxpacth_include.h:4 定义了补丁宏：XXEXPORT_START/END 声明补丁段范围，XXPATCH16/32 在指定地址插入数据，  
  XXPATCH16PTR32/XXPATCH16JMP16 等可快速写指针或跳转，所有 src/patch/*.S 都需包含此头。
  - src/patch/test_patch.S:1 示范补丁写法：XXPATCH16(0x231) 切到 ROM 偏移 0x231 写入字符串 "HAI"；编写新补丁时仿
  照这个结构添加文件即可。
  - src/patch.S:1 是由 gen_patch.py 生成的聚合文件，会把各补丁片段按地址排序、补齐 .file/.line 信息并在末尾保留 
  ROM_OFFSET (pgm.cmake 中设置)；不要手工编辑，构建时会被覆盖。
  - src/game 预留给实际 C/汇编逻辑：放入 .c 或额外 .S 文件后会自动编译进 game，其代码会被链接
  到 .text/.rodata/.data/.bss，在补丁里可以通过 XXJUMP32 或 XXPTR32 引用这些符号。

## ghidra-mcp的用法
- 函数枚举：list_methods(offset, limit) 分页列出函数；list_functions() 返回完整函数列表；
  search_functions_by_name(query, offset, limit) 模糊查找；get_function_by_address(address) 按地址定位；        
  get_current_function() 读取当前光标所在函数 (tools/bridge_mcp_ghidra.py:61, tools/bridge_mcp_ghidra.py:172,   
  tools/bridge_mcp_ghidra.py:131, tools/bridge_mcp_ghidra.py:151, tools/bridge_mcp_ghidra.py:165)
  - 符号与数据浏览：list_classes(offset, limit)、list_namespaces(offset, limit)、list_segments(offset, limit)、 
  list_imports(offset, limit)、list_exports(offset, limit)、list_data_items(offset, limit)、list_strings(offset,  limit, filter) 提供命名空间、段、导入导出、数据和字符串的分页视图 (tools/bridge_mcp_ghidra.py:68,
  tools/bridge_mcp_ghidra.py:117, tools/bridge_mcp_ghidra.py:96, tools/bridge_mcp_ghidra.py:103, tools/
  bridge_mcp_ghidra.py:110, tools/bridge_mcp_ghidra.py:124, tools/bridge_mcp_ghidra.py:273)
  - 符号重命名与类型：rename_function(old_name, new_name)、rename_function_by_address(function_address,
  new_name)、rename_data(address, new_name)、rename_variable(function_name, old_name, new_name) 重命名函数/数   
  据/局部变量；set_function_prototype(function_address, prototype) 与 set_local_variable_type(function_address, 
  variable_name, new_type) 调整函数原型与局部变量类型 (tools/bridge_mcp_ghidra.py:82, tools/
  bridge_mcp_ghidra.py:207, tools/bridge_mcp_ghidra.py:89, tools/bridge_mcp_ghidra.py:140, tools/
  bridge_mcp_ghidra.py:214, tools/bridge_mcp_ghidra.py:221)
  - 反编译与反汇编：decompile_function(name)、decompile_function_by_address(address) 获取伪代
  码；disassemble_function(address) 返回指令文本；set_decompiler_comment(address, comment) 和
  set_disassembly_comment(address, comment) 写入伪代码/反汇编注释 (tools/bridge_mcp_ghidra.py:75, tools/        
  bridge_mcp_ghidra.py:179, tools/bridge_mcp_ghidra.py:186, tools/bridge_mcp_ghidra.py:193, tools/
  bridge_mcp_ghidra.py:200)
  - 地址与上下文：get_current_address() 读取 GUI 当前地址；list_methods/list_functions 等使用 safe_get；另外    
  rename_variable、rename_data、rename_function 等通过 safe_post 将修改写回 (tools/bridge_mcp_ghidra.py:158,    
  tools/bridge_mcp_ghidra.py:65, tools/bridge_mcp_ghidra.py:197)
  - 交叉引用：get_xrefs_to(address, offset, limit)、get_xrefs_from(address, offset, limit)、
  get_function_xrefs(name, offset, limit) 查看到地址、从地址以及针对某函数的引用列表 (tools/
  bridge_mcp_ghidra.py:228, tools/bridge_mcp_ghidra.py:243, tools/bridge_mcp_ghidra.py:258)