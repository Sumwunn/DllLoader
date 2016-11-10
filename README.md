-
This cannot be installed with NMM, it will cause issues. You must install manually to avoid all issues.
-

#-------- X3DAudio1_7 README --------

**How does it work?**
It reads dll names to be loaded from DllLoader.txt.

It can also call dll export names read from a txt file named after a dll affixed with "_Exports.txt" (eg SomeDll.dll_Exports.txt).

Each dll name & dll export name must be on it's own line.

**How to install**

1. Copy X3DAudio1_7.dll from the download to Fallout 4's root folder (where Fallout4.exe is).
2. Read the notes.

**Install notes**

Your install path should be this after installing:

Fallout 4\X3DAudio1_7.dll

**How to uninstall**

Delete X3DAudio1_7.dll from Fallout 4's root folder.

**Compile Notes**

- HJWasm must be setup before opening the project.

**NOTES**

- Written in C++/ASM (Visual Studio 2015 & HJWasm).
- To compile X3DAudio1_7 with True3DSound support you must define the preprocessor `_TRUE3DSOUND_` in C++/Preprocessor & In HJWASM/General.

#-------- DINPUT8 README --------

**What is this and how does it work?**

This is my dll loader that I've created for use with all my dll mods.

It loads any dlls placed in Data\Plugins\Sumwunn. And then calls any exports listed via the dlls respective TXT exports file.

**How to install**

1. Copy DINPUT8.dll from the download to Skyrim SE's root folder (where SkyrimSE.exe is).
2. After you've installed it, all of my mods can be installed via NMM.
3. Read the notes.

**Install notes**

Your install path should be this after installing:

Skyrim Special Edition\DINPUT8.dll

**How to uninstall**

Delete DINPUT8.dll from Skyrim SE's root folder.

**How do I know if it's working?**

DllLoader.log will be generated in Data\Plugins\Sumwunn. 

It contains info about what dlls were loaded, what addresses they were loaded at, including any exports that were called along with their return values.

**For developers:**

Any dlls placed in Data\Plugins\Sumwunn will be loaded.

If you wish to have your dll exports called, you need to create a txt file that matches your dlls file name. Then append "_Exports.txt" so your txt file name looks like: YourDll.dll_Exports.txt.

Now you can use that exports txt to list your dll exports that will be called by the dll loader. Each dll export name must be on it's own line.

The working directory has not been changed, so if you want your log files to appear in Data\Plugins\Sumwunn you'll have to code it that way.

You MUST link my dll loader as a requirement when you upload your mod. This way your mod can be NMM enabled.

PM me if you any questions.

Source Code

**NOTES**

- This will not get you VAC banned in any manner as Skyrim SE does not use any anti-cheat.
- This is NOT a SKSE replacement.
- If the dll loader is not working, try restarting Steam and/or your computer.
- This is NOT NMM compatible. It must be installed manually.
- This does not use SKSE. It will also not conflict with it.
- Written in C++/ASM (Visual Studio 2015 & HJWasm).
- The Dll loaders can be used to load any dll into Fallout 4/Skyrim SE.

**CREDITS**

Bethesda for Fallout 4. (https://store.steampowered.com/app/377160/)

Bethesda for Skyrim SE. (http://store.steampowered.com/agecheck/app/489830/)

Microsoft for Visual Studio 2015. (https://www.visualstudio.com/)

The HJWasm devs. (https://github.com/Terraspace/HJWasm)
