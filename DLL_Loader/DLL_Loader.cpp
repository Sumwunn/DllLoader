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
#include <shlwapi.h>
#include <string.h>
#include <fstream>
#include <string>
#include <atlstr.h>

// We need these shwalpi functions.
#pragma warning(disable: 4995)

// Externing these for ExportsFunctions.asm.
extern "C" void* DllProxyFunction01Addr;
extern "C" void* DllProxyFunction02Addr;

// For ExportFunctions.asm.
extern "C" int SetupDllProxy();

// For SetupDllProxy.
int LoadDlls();

void* DllProxyFunction01Addr;
void* DllProxyFunction02Addr;

BOOL HasProxyDllBeenSetup = FALSE;

int SetupDllProxy() {

	// Data.
	TCHAR DllProxyWinDirPath[MAX_PATH];

	HMODULE DllProxy_hModule;

	LPCTSTR DllProxyName = L"X3DAudio1_7.dll";
	LPCTSTR DllSystemPath = L"\\System32\\";
	LPCSTR DllProxyFunction01Name = "X3DAudioCalculate";
	LPCSTR DllProxyFunction02Name = "X3DAudioInitialize";

	if (HasProxyDllBeenSetup == TRUE) {
		return 0;
	}

	GetWindowsDirectory(DllProxyWinDirPath, MAX_PATH);
	_tcscat_s(DllProxyWinDirPath, DllSystemPath);
	_tcscat_s(DllProxyWinDirPath, DllProxyName);
	DllProxy_hModule = LoadLibrary(DllProxyWinDirPath);

	DllProxyFunction01Addr = GetProcAddress(DllProxy_hModule, DllProxyFunction01Name);
	DllProxyFunction02Addr = GetProcAddress(DllProxy_hModule, DllProxyFunction02Name);

	// This works great because X3DAudio's function gets called just before Fallout 4's intro starts.
	// So no waiting for Steam decryption, yay!
	LoadDlls();

	HasProxyDllBeenSetup = TRUE;

	return 0;
}

int LoadDlls() {

	HMODULE hModule = NULL;

	// Check for expected exe.
	if (GetModuleHandleEx(NULL, L"Fallout4.exe", &hModule) != NULL) {
		// Open up file with dlls.
		std::ifstream DllLoaderTxtFile;
		DllLoaderTxtFile.open("DllLoader.txt");
		// Does the dll list exist?
		if (!DllLoaderTxtFile) {
			// Nope!
			return 0;
		}
		// Read txt file with dll names and load them.
		std::string DllToLoad;
		while (std::getline(DllLoaderTxtFile, DllToLoad))
		{
			TCHAR Buffer[MAX_PATH]; // Used for both name of dll to be loaded & it's exports txt filename.
			// Load dll.
			_tcscpy_s(Buffer, MAX_PATH, CA2T(DllToLoad.c_str()));
			HMODULE Dll_hModule = LoadLibrary(Buffer);
			// Skip dll if we didn't get hModule from LoadLibrary.
			if (Dll_hModule == NULL) {
				continue;
			}
			//////////////// SETUP EXTENSION, READ EXPORTS TXT THEN CALL FUNCTIONS ////////////////
			// Setup extension for dll exports txt.
			PathRemoveExtension(Buffer); // Remove DLL extension.
			_tcscat_s(Buffer, MAX_PATH, L"_Exports"); // Then append this.
			PathAddExtension(Buffer, L".txt"); // Add txt extension.
			// Open up file with dll exports.
			std::ifstream DllExportsTxtFile;
			DllExportsTxtFile.open(Buffer);
			// Skip Exports if txt doesn't exist.
			if (!DllExportsTxtFile) {
				continue;
			}
			// The Read 'N Call.
			std::string DllExportToCall;
			while (std::getline(DllExportsTxtFile, DllExportToCall))
			{
				char Buffer[MAX_PATH];
				FARPROC ExportAddress = NULL;
				// Convert std string to char.
				strcpy_s(Buffer, MAX_PATH, CA2A(DllExportToCall.c_str()));
				// Get dll export address.
				ExportAddress = GetProcAddress(Dll_hModule, Buffer);
				// Skip if address does not get returned.
				if (ExportAddress != NULL) {
					// Call it.
					ExportAddress();
				}
			}
			// Cleanup.
			DllExportsTxtFile.close();
		}
		// Cleanup.
		DllLoaderTxtFile.close();
	}

	return 0;
}
