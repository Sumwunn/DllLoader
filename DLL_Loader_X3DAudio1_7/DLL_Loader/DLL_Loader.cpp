/*                             The MIT License (MIT)

Copyright (c) 2016 Sumwunn @ github.com

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.*/

#include "stdafx.h"
#include <windows.h>
#include <string.h>
#include <fstream>
#include <string>
#include <atlstr.h>

// Externing these for ExportsFunctions.asm.
extern "C" int SetupDllProxy();
#ifndef _TRUE3DSOUND_
extern "C" void* DllProxyFunction01Addr;
extern "C" void* DllProxyFunction02Addr;

void* DllProxyFunction01Addr = NULL;
void* DllProxyFunction02Addr = NULL;
#endif

// For SetupDllProxy.
int LoadDlls();

BOOL HasProxyDllBeenSetup = FALSE;

int SetupDllProxy() {

	if (HasProxyDllBeenSetup == TRUE) {
		return 0;
	}

#ifndef _TRUE3DSOUND_
	// Dll Proxy Data.
	TCHAR DllProxyWinDirPath[MAX_PATH];

	HMODULE DllProxy_hModule = NULL;

	LPCTSTR DllProxyPath = L"\\System32\\X3DAudio1_7.dll";
	LPCSTR DllProxyFunction01Name = "X3DAudioCalculate";
	LPCSTR DllProxyFunction02Name = "X3DAudioInitialize";

	GetWindowsDirectory(DllProxyWinDirPath, MAX_PATH);
	_tcscat_s(DllProxyWinDirPath, DllProxyPath);
	DllProxy_hModule = LoadLibrary(DllProxyWinDirPath);
	DllProxyFunction01Addr = GetProcAddress(DllProxy_hModule, DllProxyFunction01Name);
	DllProxyFunction02Addr = GetProcAddress(DllProxy_hModule, DllProxyFunction02Name);
#endif

	HasProxyDllBeenSetup = TRUE;

	// This works great because X3DAudio's function gets called just before Fallout 4's intro starts.
	// So no waiting for Steam decryption, yay!
	LoadDlls();

	return 0;
}

int LoadDlls() {

	LPCTSTR ExpectedProcess = L"Fallout4.exe";

	HMODULE hModule = NULL;

	std::wofstream LogFile;

	// Check for expected exe.
	if (GetModuleHandleEx(NULL, ExpectedProcess, &hModule) != NULL) {
		// Logging.
		LogFile.open(L"Data\\Plugins\\Sumwunn\\DllLoader.log");
		// Log file creation failed.
		if (!LogFile) {
			return 0;
		}
		// Data.
		WIN32_FIND_DATA FindFileData;
		HANDLE hFind;
		HMODULE hModule;
		TCHAR cFileNamePath[MAX_PATH];
		// Search for dlls in Data\Plugins\Sumwunn
		for (hFind = FindFirstFile(L"Data\\Plugins\\Sumwunn\\*.dll", &FindFileData); hFind != INVALID_HANDLE_VALUE && GetLastError() != ERROR_NO_MORE_FILES; FindNextFile(hFind, &FindFileData)) {
			// Load dll.
			_tcscpy_s(cFileNamePath, MAX_PATH, L"Data\\Plugins\\Sumwunn\\"); // Add dll path.
			_tcscat_s(cFileNamePath, MAX_PATH, FindFileData.cFileName); // Add dll name.
			hModule = LoadLibrary(cFileNamePath);
			if (hModule == NULL) {
				// Log message. Dll did not load.
				LogFile << FindFileData.cFileName << L" | Loading Failed (hModule NULL)" << std::endl;
			}
			else {
				// Log message. Dll loaded OK.
				LogFile << FindFileData.cFileName << L" | Loaded OK" << L" | Address: " << hModule << std::endl;
			}
			//////////////// SETUP EXTENSION, READ EXPORTS TXT THEN CALL FUNCTIONS ////////////////
			// Setup extension for dll exports txt.
			_tcscat_s(cFileNamePath, MAX_PATH, L"_Exports.txt"); // Add txt extension.
																 // Open up file with dll exports.
			std::ifstream DllExportsTxtFile;
			DllExportsTxtFile.open(cFileNamePath);
			// Skip Exports if txt doesn't exist.
			if (!DllExportsTxtFile) {
				continue;
			}
			// The Read 'N Call.
			std::string DllExportToCall;
			while (std::getline(DllExportsTxtFile, DllExportToCall))
			{
				char ExportName[MAX_PATH];
				FARPROC ExportAddress = NULL;
				INT_PTR ReturnValue = NULL;
				// Convert std string to char.
				strcpy_s(ExportName, MAX_PATH, CA2A(DllExportToCall.c_str()));
				// Get dll export address.
				ExportAddress = GetProcAddress(hModule, ExportName);
				// Export name not FOUND!
				if (ExportAddress == NULL) {
					// Log message. Export called.
					LogFile << L"- " << ExportName << L" | Export not found" << std::endl;
				}
				// Export name found!
				else {
					// Call it.
					ReturnValue = ExportAddress();
					// Logging.
					// Log message. Export called.
					LogFile << L"- " << ExportName << L" | Export Called" << L" | Return Value: " << ReturnValue << L" | Address: " << ExportAddress << std::endl;
				}
				// Newline.
				LogFile << std::endl;
			}
			// Cleanup.
			DllExportsTxtFile.close();
		}
		// Cleanup.
		FindClose(hFind);
	}

	// Cleanup.
	LogFile.close();

	return 0;
}
