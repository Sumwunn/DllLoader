/*                             The MIT License (MIT)

Copyright (c) 2024 Sumwunn @ github.com

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
#include <strsafe.h>
#include <detours.h>
#include <string>
#include <fstream>
#include <iostream>

// Arrays
#define DLL_PROXY_NAMES_MAX 193 + 1
void* DllProxyFuncAddrs[DLL_PROXY_NAMES_MAX] = { 0 };
LPCSTR DllProxyFuncNames[DLL_PROXY_NAMES_MAX] =
{
  "mciExecute",
  "CloseDriver",
  "DefDriverProc",
  "DriverCallback",
  "DrvGetModuleHandle",
  "GetDriverModuleHandle",
  "NotifyCallbackData",
  "OpenDriver",
  "PlaySound",
  "PlaySoundA",
  "PlaySoundW",
  "SendDriverMessage",
  "WOW32DriverCallback",
  "WOW32ResolveMultiMediaHandle",
  "WOWAppExit",
  "aux32Message",
  "auxGetDevCapsA",
  "auxGetDevCapsW",
  "auxGetNumDevs",
  "auxGetVolume",
  "auxOutMessage",
  "auxSetVolume",
  "joy32Message",
  "joyConfigChanged",
  "joyGetDevCapsA",
  "joyGetDevCapsW",
  "joyGetNumDevs",
  "joyGetPos",
  "joyGetPosEx",
  "joyGetThreshold",
  "joyReleaseCapture",
  "joySetCapture",
  "joySetThreshold",
  "mci32Message",
  "mciDriverNotify",
  "mciDriverYield",
  "mciFreeCommandResource",
  "mciGetCreatorTask",
  "mciGetDeviceIDA",
  "mciGetDeviceIDFromElementIDA",
  "mciGetDeviceIDFromElementIDW",
  "mciGetDeviceIDW",
  "mciGetDriverData",
  "mciGetErrorStringA",
  "mciGetErrorStringW",
  "mciGetYieldProc",
  "mciLoadCommandResource",
  "mciSendCommandA",
  "mciSendCommandW",
  "mciSendStringA",
  "mciSendStringW",
  "mciSetDriverData",
  "mciSetYieldProc",
  "mid32Message",
  "midiConnect",
  "midiDisconnect",
  "midiInAddBuffer",
  "midiInClose",
  "midiInGetDevCapsA",
  "midiInGetDevCapsW",
  "midiInGetErrorTextA",
  "midiInGetErrorTextW",
  "midiInGetID",
  "midiInGetNumDevs",
  "midiInMessage",
  "midiInOpen",
  "midiInPrepareHeader",
  "midiInReset",
  "midiInStart",
  "midiInStop",
  "midiInUnprepareHeader",
  "midiOutCacheDrumPatches",
  "midiOutCachePatches",
  "midiOutClose",
  "midiOutGetDevCapsA",
  "midiOutGetDevCapsW",
  "midiOutGetErrorTextA",
  "midiOutGetErrorTextW",
  "midiOutGetID",
  "midiOutGetNumDevs",
  "midiOutGetVolume",
  "midiOutLongMsg",
  "midiOutMessage",
  "midiOutOpen",
  "midiOutPrepareHeader",
  "midiOutReset",
  "midiOutSetVolume",
  "midiOutShortMsg",
  "midiOutUnprepareHeader",
  "midiStreamClose",
  "midiStreamOpen",
  "midiStreamOut",
  "midiStreamPause",
  "midiStreamPosition",
  "midiStreamProperty",
  "midiStreamRestart",
  "midiStreamStop",
  "mixerClose",
  "mixerGetControlDetailsA",
  "mixerGetControlDetailsW",
  "mixerGetDevCapsA",
  "mixerGetDevCapsW",
  "mixerGetID",
  "mixerGetLineControlsA",
  "mixerGetLineControlsW",
  "mixerGetLineInfoA",
  "mixerGetLineInfoW",
  "mixerGetNumDevs",
  "mixerMessage",
  "mixerOpen",
  "mixerSetControlDetails",
  "mmDrvInstall",
  "mmGetCurrentTask",
  "mmTaskBlock",
  "mmTaskCreate",
  "mmTaskSignal",
  "mmTaskYield",
  "mmioAdvance",
  "mmioAscend",
  "mmioClose",
  "mmioCreateChunk",
  "mmioDescend",
  "mmioFlush",
  "mmioGetInfo",
  "mmioInstallIOProcA",
  "mmioInstallIOProcW",
  "mmioOpenA",
  "mmioOpenW",
  "mmioRead",
  "mmioRenameA",
  "mmioRenameW",
  "mmioSeek",
  "mmioSendMessage",
  "mmioSetBuffer",
  "mmioSetInfo",
  "mmioStringToFOURCCA",
  "mmioStringToFOURCCW",
  "mmioWrite",
  "mmsystemGetVersion",
  "mod32Message",
  "mxd32Message",
  "sndPlaySoundA",
  "sndPlaySoundW",
  "tid32Message",
  "timeBeginPeriod",
  "timeEndPeriod",
  "timeGetDevCaps",
  "timeGetSystemTime",
  "timeGetTime",
  "timeKillEvent",
  "timeSetEvent",
  "waveInAddBuffer",
  "waveInClose",
  "waveInGetDevCapsA",
  "waveInGetDevCapsW",
  "waveInGetErrorTextA",
  "waveInGetErrorTextW",
  "waveInGetID",
  "waveInGetNumDevs",
  "waveInGetPosition",
  "waveInMessage",
  "waveInOpen",
  "waveInPrepareHeader",
  "waveInReset",
  "waveInStart",
  "waveInStop",
  "waveInUnprepareHeader",
  "waveOutBreakLoop",
  "waveOutClose",
  "waveOutGetDevCapsA",
  "waveOutGetDevCapsW",
  "waveOutGetErrorTextA",
  "waveOutGetErrorTextW",
  "waveOutGetID",
  "waveOutGetNumDevs",
  "waveOutGetPitch",
  "waveOutGetPlaybackRate",
  "waveOutGetPosition",
  "waveOutGetVolume",
  "waveOutMessage",
  "waveOutOpen",
  "waveOutPause",
  "waveOutPrepareHeader",
  "waveOutReset",
  "waveOutRestart",
  "waveOutSetPitch",
  "waveOutSetPlaybackRate",
  "waveOutSetVolume",
  "waveOutUnprepareHeader",
  "waveOutWrite",
  "wid32Message",
  "wod32Message",
};

// ------------------------------------------------------------

// C++
void DetoursStart();
void SetupDllProxy();
bool cdaDetour(LPCSTR, LPSECURITY_ATTRIBUTES);

// For ExportFunctions.asm
extern "C" bool _ExportGetRealAddr(void*);
extern "C" void* ExportRealAddr;

// Misc
HMODULE Dll_hModule;
HMODULE DllProxy_hModule = NULL;
bool ProxyDllSetup = false;

void* ExportRealAddr;

// For Detours
static BOOL(WINAPI* hookTarget)(LPCSTR lpPathName, LPSECURITY_ATTRIBUTES lpSecurityAttributes) = CreateDirectoryA;

// ------------------------------------------------------------

void Setup(HMODULE hModule)
{
	Dll_hModule = hModule;
	DetoursStart();
}

void DetoursStart()
{
	DetourTransactionBegin();
	DetourUpdateThread(GetCurrentThread());
	DetourAttach(&(PVOID&)hookTarget, cdaDetour);
	DetourTransactionCommit();

	return;
}

void DetoursEnd()
{
	DetourTransactionBegin();
	DetourUpdateThread(GetCurrentThread());
	DetourDetach(&(PVOID&)hookTarget, cdaDetour);
	DetourTransactionCommit();

	return;
}

void SetupDllProxy() 
{
	if (ProxyDllSetup)
		return;

	// Dll Proxy Data
	TCHAR DllProxyWinDirPath[MAX_PATH];
	LPCTSTR DllProxyPath = L"\\System32\\winmm.dll";

	// Setup Dll proxy
	GetWindowsDirectory(DllProxyWinDirPath, MAX_PATH);
	StringCchCat(DllProxyWinDirPath, MAX_PATH, DllProxyPath);
	DllProxy_hModule = LoadLibrary(DllProxyWinDirPath);

	// First function is an oridinal (starting at 0x02)
	DllProxyFuncAddrs[0] = GetProcAddress(DllProxy_hModule, MAKEINTRESOURCEA(0x02));

	for (int i = 1; i < DLL_PROXY_NAMES_MAX - 1; i++)
		DllProxyFuncAddrs[i] = GetProcAddress(DllProxy_hModule, DllProxyFuncNames[i]);

	ProxyDllSetup = true;

	return;
}

bool _ExportGetRealAddr(void* expectedAddr)
{
	SetupDllProxy();

	for (int i = 0; i < DLL_PROXY_NAMES_MAX; i++)
	{
		if (GetProcAddress(Dll_hModule, DllProxyFuncNames[i]) == expectedAddr)
		{
			ExportRealAddr = DllProxyFuncAddrs[i];
			return true;
		}
	}

	return false;
}

// CreateDirectoryA Hook
bool cdaDetour(LPCSTR pN, LPSECURITY_ATTRIBUTES sA) {

	// Config
	TCHAR ConfigFilePath[MAX_PATH];
	bool bEnableLogging;

	// File IO
	std::wofstream LogFile;

	// Dll Info
	WIN32_FIND_DATA FindFileData;
	HANDLE hFind = NULL;
	HMODULE hModule = NULL;
	TCHAR cFileNamePath[MAX_PATH];

	// Get config path
	GetCurrentDirectory(MAX_PATH, ConfigFilePath);
	_tcscat_s(ConfigFilePath, MAX_PATH, L"\\Data\\Plugins\\Sumwunn\\DllLoader.ini");
	// Get config settings
	bEnableLogging = GetPrivateProfileInt(L"General", L"bEnableLogging", true, ConfigFilePath);

	// Logging
	if (bEnableLogging)
	{
		LogFile.open(L"Data\\Plugins\\Sumwunn\\DllLoader.log");
		// Log file creation failed.
		if (!LogFile)
			bEnableLogging = false;
	}

	// Search for dlls in Data\Plugins\Sumwunn
	for (hFind = FindFirstFile(L"Data\\Plugins\\Sumwunn\\*.dll", &FindFileData); hFind != INVALID_HANDLE_VALUE && GetLastError() != ERROR_NO_MORE_FILES; FindNextFile(hFind, &FindFileData)) 
	{	
		// Load dll
		_tcscpy_s(cFileNamePath, MAX_PATH, L"Data\\Plugins\\Sumwunn\\"); // Add dll path
		_tcscat_s(cFileNamePath, MAX_PATH, FindFileData.cFileName); // Add dll name
		hModule = LoadLibrary(cFileNamePath);

		// Logging
		if (bEnableLogging)
		{
			if (hModule == NULL)
				// Log message. Dll did not load
				LogFile << FindFileData.cFileName << L" | Loading Failed (hModule NULL)" << std::endl;
			else
				// Log message. Dll loaded OK
				LogFile << FindFileData.cFileName << L" | Loaded OK" << L" | Address: " << hModule << std::endl;
		}

		//////////////// SETUP EXTENSION, READ EXPORTS TXT THEN CALL FUNCTIONS ////////////////

		// Setup extension for dll exports txt
		_tcscat_s(cFileNamePath, MAX_PATH, L"_Exports.txt"); // Add txt extension
		// Open up file with dll exports
		std::ifstream DllExportsTxtFile;
		DllExportsTxtFile.open(cFileNamePath);

		// Skip Exports if txt doesn't exist
		if (!DllExportsTxtFile)
			continue;

		// The Read 'N Call
		std::string DllExportToCall;
		while (std::getline(DllExportsTxtFile, DllExportToCall))
		{
			char ExportName[MAX_PATH];
			FARPROC ExportAddress = NULL;
			INT_PTR ReturnValue = NULL;
			// Convert std string to char
			strcpy_s(ExportName, MAX_PATH, DllExportToCall.c_str());
			// Get dll export address
			ExportAddress = GetProcAddress(hModule, ExportName);

			// Export name not found
			if (ExportAddress == NULL) 
			{
				// Logging
				if (bEnableLogging)
					// Log message; export called
					LogFile << L"- " << ExportName << L" | Export not found" << std::endl;
			}
			// Export name found
			else 
			{
				// Call it
				ReturnValue = ExportAddress();
				// Logging
				if (bEnableLogging)
					// Log message; export called
					LogFile << L"- " << ExportName << L" | Export Called" << L" | Return Value: " << ReturnValue << L" | Address: " << ExportAddress << std::endl;
			}
		}

		// Cleanup
		DllExportsTxtFile.close();
	}

	// Cleanup
	FindClose(hFind);

	if (bEnableLogging)
		LogFile.close();

	// Done, release Detour
	DetoursEnd();

	// Call Original Function
	return CreateDirectoryA(pN, sA);
}