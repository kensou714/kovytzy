# Kovytzy Build & Tooling Guide

## Overview
This repository builds and patches the `ytzy_v201cn` ROM family:

- `gen_patch.py` bundles the assembly patches in `src/patch/` into `src/patch.S`.
- `app_patch.py` takes the linked `game` ELF, extracts the `.rom`/`.ram` segments via `objcopy`, and rewrites the original ROM to produce `ytzy_v201cn_h.rom`.
- `tools/bridge_mcp_ghidra.py` exposes a Model Context Protocol (MCP) service that converts Ghidra REST endpoints into remotely callable tools.

## Prerequisites
1. **m68k-elf toolchain**: install a toolchain that provides `m68k-elf-objcopy.exe`, `m68k-elf-gcc.exe`, etc. Ensure the binary directory (e.g. `D:\m68k-elf\bin`) is on `PATH`, or configure `TC_PATH` during setup.
2. **CMake**: version 3.12 or newer. On Windows invoke it via `D:/CMake/bin/cmake.exe`.
3. **Python 3**: all scripts target Python 3. Make sure the `python` command resolves to a 3.x interpreter.
4. **Python packages (optional, MCP bridge only)**: `bridge_mcp_ghidra.py` depends on `requests` and `mcp`. Install them with `pip install requests mcp`.
5. **Ghidra (optional)**: to use the MCP bridge, unpack `tools/GhidraMCP-1-4.zip` and load the provided server script into Ghidra as described inside the archive.

## Build Workflow
### Configure once
```bash
mkdir build
cd build
"D:/CMake/bin/cmake.exe" .. -DCMAKE_TOOLCHAIN_FILE=../pgm.cmake -G "Unix Makefiles"
```
> To override the toolchain path, set `TC_PATH="D:/m68k-elf/bin/"` before running CMake, or edit `pgm.cmake` accordingly.

### Compile and generate ROM
```bash
cmake --build . -- -j8
```
You can also call `make -j8` directly.

Artifacts produced:
- `build/game`: the final executable image.
- `build/game.map`: link map produced by the linker.
- `ytzy_v201cn_h.rom`: patched ROM written to the repository root.

To regenerate only the patch assembly file:
```bash
cmake --build . --target generate_patch
```

`build.bat` replicates the same workflow and additionally copies the ROM to a MAME directory; adjust paths in that batch file if you rely on it.

## Script reference
### `gen_patch.py`
```
python gen_patch.py <ROM_OFFSET> <OUTPUT_PATCH_S> <PATCH_SOURCE...>
```
Used automatically by CMake to merge all `.S` files under `src/patch/` into `src/patch.S` sorted by patch address.

### `app_patch.py`
```
python app_patch.py <CROSS-PREFIX> <ELF> <MAP> <ORI_BIN> <OUTPUT_BIN>
```
Invoked after the `game` target links. Runs `<CROSS-PREFIX>objcopy.exe` to extract the ROM/RAM sections from the ELF, splices them into the original ROM, and writes the patched image to disk.

## Ghidra MCP bridge
`tools/bridge_mcp_ghidra.py` turns Ghidra REST endpoints into MCP tools so that MCP-capable clients can inspect or edit the active project.

### Launch steps
1. Install the Ghidra server script from `tools/GhidraMCP-1-4.zip` and start the REST service (default URL `http://127.0.0.1:8080/`).
2. Open the target program in Ghidra (for example `ytzy_v201cn_d.rom`) and ensure the server reports it is running.
3. Start the MCP bridge from the repository root:
   ```bash
   python tools/bridge_mcp_ghidra.py --ghidra-server http://127.0.0.1:8080/
   ```
   - `--transport stdio` (default) serves MCP over stdin/stdout.
   - `--transport sse --mcp-host 0.0.0.0 --mcp-port 8081` exposes an SSE endpoint instead.

### Exposed tools
The script registers many MCP tools, including:
- `list_methods(offset=0, limit=100)` - list functions with pagination.
- `decompile_function(name)` - fetch decompiled C for the specified function.
- `rename_function(old_name, new_name)` / `rename_data(address, new_name)` - rename symbols.
- `list_segments`, `list_strings(filter=None)`, `get_xrefs_to(address)` - inspect memory segments, strings, and cross-references.
- `set_function_prototype(function_address, prototype)` and similar helpers for adjusting prototypes and variable types.

Import the script in Python (`from tools.bridge_mcp_ghidra import list_methods`) or connect via an MCP-aware client to call these helpers directly.

## Troubleshooting
- **`m68k-elf-objcopy.exe` not found**: double-check the toolchain path on `PATH`, or set `TC_PATH` in `pgm.cmake`.
- **`python` resolves to Python 2**: ensure `python --version` outputs 3.x or use an explicit virtual environment.
- **Cannot reach Ghidra REST server**: confirm the Ghidra script is running and that the MCP bridge points to the same host/port.

## Useful references
- `build.bat` - example batch script that builds and copies the ROM into a MAME install.
- `tools/GhidraMCP-1-4.zip` - Ghidra-side MCP plugin archive.

Keep the toolchain and Python dependencies aligned with these requirements and the project should build and integrate with Ghidra smoothly.
