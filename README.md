# GBA Project Template

## Setup

1. Install `DevKitPro`

2. Install `VSCode` Extension `C/C++`

3. Install `mGBA`

4. Clone template to `DevKitPro` directory

5. Setup Workspace Settings

   ```json
   {
       "clangd": "Disabled", // if install `clangd` extension
       "C_Cpp.intelliSenseEngine": "default",
       "C_Cpp.formatting": "clangFormat",
       "C_Cpp.default.compilerPath": ".../DevKitPro/devkitARM/bin/arm-none-eabi-gcc.exe",
       "C_Cpp.default.includePath": [
           ".ext/*",
           "./ext/gba/*",
           "./ext/tonc/*",
           "./include/*",
           "./include/**",
       ],
       "C_Cpp.default.intelliSenseMode": "windows-gcc-arm",
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
