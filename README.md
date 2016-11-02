##Dll Loader for Fallout 4 & Skyrim SE##

**What is this?**

It's a dll that loads other dlls by using a system dll as a proxy.
- X3DAudio1_7 is for Fallout 4.
- DINPUT8 is for Skyrim SE.

It reads dlls to be loaded from DllLoader.txt (create manually).

It can also call dll export names read from a txt file named after dll affixed with "_Exports.txt" (eg SomeDll.dll_Exports.txt).

Each dll name & dll export name must be on it's own line.

**The Loader Works Like This**

Reads DllLoader.txt -> Loads Dlls -> Looks and reads from export txts -> Calls dll exports for each dll if any -> End.

**Compile Notes**

- HJWasm must be setup before opening the project.

**NOTES**

- Written in C++/ASM (Visual Studio 2015 & HJWasm).
- To compile X3DAudio1_7 with True3DSound support you must define the preprocessor "_TRUE3DSOUND_" in C++/Preprocessor & In HJWASM/General.

**CREDITS**

Bethesda for Fallout 4. (https://store.steampowered.com/app/377160/)

Bethesda for Skyrim SE. (http://store.steampowered.com/agecheck/app/489830/)

Microsoft for Visual Studio 2015. (https://www.visualstudio.com/)

The HJWasm devs. (https://github.com/Terraspace/HJWasm)
