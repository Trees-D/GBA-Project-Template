# GBA Project Template

## Setup

1. Install `DevKitPro`

2. Install `VSCode` Extension `C/C++`

3. Install `mGBA`

4. Clone template to `DevKitPro` directory

5. Setup Workspace Settings

   ```json
   {
       "C_Cpp.autocomplete": "default",
       "C_Cpp.autocompleteAddParentheses": true,
       "C_Cpp.intelliSenseEngine": "default",
       "C_Cpp.formatting": "clangFormat",
       "C_Cpp.default.compilerPath": ".../DevKitPro/devkitARM/bin/arm-none-eabi-gcc.exe",
       "C_Cpp.default.includePath": [
           ".../DevKitPro/projects/template/ext/*",
           ".../DevKitPro/projects/template/ext/gba/*",
           ".../DevKitPro/projects/template/ext/tonc/*",
           ".../DevKitPro/projects/template/include/*",
           ".../DevKitPro/projects/template/include/**",
       ],
       "files.associations": {
           "*.h": "c"
       },
   }
   ```

## Build, Run and Clean

```bash
$> cd Project
$> make -j 12
$> build/PROJECT.gba
$> make clean
```
