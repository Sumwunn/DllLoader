/*                             The MIT License (MIT)

Copyright (c) 2017 Sumwunn @ github.com

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
#include <iostream>
#include <string>
#include <atlstr.h>

// Externing these for ExportsFunctions.asm.
extern "C" void* DllProxyFunction01Addr;
extern "C" void* DllProxyFunction02Addr;
extern "C" void* DllProxyFunction03Addr;
extern "C" void* DllProxyFunction04Addr;
extern "C" void* DllProxyFunction05Addr;

// For ExportFunctions.asm.
extern "C" int SetupDllProxy();

// For SetupDllProxy.
int LoadDlls();

void* DllProxyFunction01Addr;
void* DllProxyFunction02Addr;
void* DllProxyFunction03Addr;
void* DllProxyFunction04Addr;
void* DllProxyFunction05Addr;

BOOL ProxyDllLoaded = FALSE;

int SetupDllProxy() {

	// Dll Proxy Data.
	TCHAR DllProxyWinDirPath[MAX_PATH];

	HMODULE DllProxy_hModule = NULL;

	LPCTSTR DllProxyPath = L"\\System32\\DINPUT8.dll";
	LPCSTR DllProxyFunction01Name = "DirectInput8Create";
	LPCSTR DllProxyFunction02Name = "DllCanUnloadNow";
	LPCSTR DllProxyFunction03Name = "DllGetClassObject";
	LPCSTR DllProxyFunction04Name = "DllRegisterServer";
	LPCSTR DllProxyFunction05Name = "DllUnregisterServer";

	if (ProxyDllLoaded == TRUE) {
		return 0;
	}

	GetWindowsDirectory(DllProxyWinDirPath, MAX_PATH);
	_tcscat_s(DllProxyWinDirPath, DllProxyPath);
	DllProxy_hModule = LoadLibrary(DllProxyWinDirPath);

	DllProxyFunction01Addr = GetProcAddress(DllProxy_hModule, DllProxyFunction01Name);
	DllProxyFunction02Addr = GetProcAddress(DllProxy_hModule, DllProxyFunction02Name);
	DllProxyFunction03Addr = GetProcAddress(DllProxy_hModule, DllProxyFunction03Name);
	DllProxyFunction04Addr = GetProcAddress(DllProxy_hModule, DllProxyFunction04Name);
	DllProxyFunction05Addr = GetProcAddress(DllProxy_hModule, DllProxyFunction05Name);

	ProxyDllLoaded = TRUE;

	LoadDlls();

	return 0;
}

int LoadDlls() {

	TCHAR ConfigFilePath[MAX_PATH];
	int iEnableLogging = 1;
	// 0 = Disable.
	// 1 = Enable.

	// Get config path.
	GetCurrentDirectory(MAX_PATH, ConfigFilePath);
	_tcscat_s(ConfigFilePath, MAX_PATH, L"\\Data\\Plugins\\Sumwunn\\DllLoader.ini");
	// Get config settings.
	iEnableLogging = GetPrivateProfileInt(L"General", L"iEnableLogging", 1, ConfigFilePath);

	// Checking for incorrect values.
	if (iEnableLogging < 0 || iEnableLogging > 1)
	{
		iEnableLogging = 1;
	}

	// Logging.
	std::wofstream LogFile;
	if (iEnableLogging == 1) 
	{
		// Logging.
		LogFile.open(L"Data\\Plugins\\Sumwunn\\DllLoader.log");
		// Log file creation failed.
		if (!LogFile) {
			return 0;
		}
	}
	// Data.
	WIN32_FIND_DATA FindFileData;
	HANDLE hFind = NULL;
	HMODULE hModule = NULL;
	TCHAR cFileNamePath[MAX_PATH];
	// Search for dlls in Data\Plugins\Sumwunn
	for (hFind = FindFirstFile(L"Data\\Plugins\\Sumwunn\\*.dll", &FindFileData); hFind != INVALID_HANDLE_VALUE && GetLastError() != ERROR_NO_MORE_FILES; FindNextFile(hFind, &FindFileData)) {
		// Load dll.
		_tcscpy_s(cFileNamePath, MAX_PATH, L"Data\\Plugins\\Sumwunn\\"); // Add dll path.
		_tcscat_s(cFileNamePath, MAX_PATH, FindFileData.cFileName); // Add dll name.
		hModule = LoadLibrary(cFileNamePath);
		// Logging.
		if (iEnableLogging == 1)
		{
			if (hModule == NULL) {
				// Log message. Dll did not load.
				LogFile << FindFileData.cFileName << L" | Loading Failed (hModule NULL)" << std::endl;
			}
			else {
				// Log message. Dll loaded OK.
				LogFile << FindFileData.cFileName << L" | Loaded OK" << L" | Address: " << hModule << std::endl;
			}
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
				// Logging.
				if (iEnableLogging == 1)
				{
					// Log message. Export called.
					LogFile << L"- " << ExportName << L" | Export not found" << std::endl;
				}
			}
			// Export name found!
			else {
				// Call it.
				ReturnValue = ExportAddress();
				// Logging.
				if (iEnableLogging == 1)
				{
					// Log message. Export called.
					LogFile << L"- " << ExportName << L" | Export Called" << L" | Return Value: " << ReturnValue << L" | Address: " << ExportAddress << std::endl;
				}
			}
		}
		// Cleanup.
		DllExportsTxtFile.close();
	}
	// Cleanup.
	FindClose(hFind);

	// Logging.
	if (iEnableLogging == 1)
	{
		// Cleanup.
		LogFile.close();
	}

	return 0;
}