;                             The MIT License (MIT)
;
;            Copyright (c) 2016 Sumwunn @ github.com
;
;Permission is hereby granted, free of charge, to any person obtaining a copy of
; this software and associated documentation files (the "Software"), to deal in
;  the Software without restriction, including without limitation the rights to
;use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
;the Software, and to permit persons to whom the Software is furnished to do so,
;                      subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
;                copies or substantial portions of the Software.
;
;   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
; FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
; COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
;    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

IFDEF _WIN32

.486
.MODEL FLAT, C
OPTION CASEMAP:NONE

.code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

ENDIF

IFDEF _WIN64

.x64
OPTION CASEMAP:NONE
OPTION FRAME:AUTO
OPTION WIN64:11
OPTION STACKBASE:RSP

SetupDllProxy PROTO

EXTERN DllProxyFunction01Addr:QWORD
EXTERN DllProxyFunction02Addr:QWORD
EXTERN DllProxyFunction03Addr:QWORD
EXTERN DllProxyFunction04Addr:QWORD
EXTERN DllProxyFunction05Addr:QWORD

.code

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

DllProxyFunction01 proc frame

push rcx
push rdx
push r8
push r9

sub rsp, 28h
call SetupDllProxy
add rsp, 28h

pop r9
pop r8
pop rdx
pop rcx

jmp [DllProxyFunction01Addr]

DllProxyFunction01 endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

DllProxyFunction02 proc frame

jmp [DllProxyFunction02Addr]

DllProxyFunction02 endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

DllProxyFunction03 proc frame

jmp [DllProxyFunction03Addr]

DllProxyFunction03 endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

DllProxyFunction04 proc frame

jmp [DllProxyFunction04Addr]

DllProxyFunction04 endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

DllProxyFunction05 proc frame

jmp [DllProxyFunction05Addr]

DllProxyFunction05 endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい�

ENDIF

END