##Dll Loader for Fallout 4##

**What is this?**

It's a dll that loads other dlls into Fallout 4 by using X3DAudio1_7.dll as a proxy.

It reads dlls to be loaded from DllLoader.txt (create manually).

It can also call dll export names read from a txt file named after dll affixed with "_Exports" (eg SomeDll_Exports.txt).

Each dll name & dll export name must be on it's own line.

**The Loader Works Like This**

Reads DllLoader.txt -> Loads Dlls -> Looks and reads from export txts -> Calls dll exports for each dll if any -> End.

**Compile Notes**

- HJWasm must be setup before opening the project.

**NOTES**

- Written in C++/ASM (Visual Studio 2015 & HJWasm).

**CREDITS**

Bethesda for Fallout 4. (https://store.steampowered.com/app/377160/)

Microsoft for Visual Studio 2015. (https://www.visualstudio.com/)

The HJWasm devs. (https://github.com/Terraspace/HJWasm)
