;                             The MIT License (MIT)
;
;            Copyright (c) 2024 Sumwunn @ github.com
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

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

IFDEF _WIN32

.486
.MODEL FLAT, C
OPTION CASEMAP:NONE

.code

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

ENDIF

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

IFDEF _WIN64

.x64
OPTION CASEMAP:NONE
OPTION FRAME:AUTO
OPTION WIN64:11

ExportGetRealAddr PROTO C
EXTERN ExportRealAddr:QWORD

.data?

raxBackup QWORD ?
rbxBackup QWORD ?
rcxBackup QWORD ?
rdxBackup QWORD ?
rbpBackup QWORD ?
rsiBackup QWORD ?
rdiBackup QWORD ?

r8Backup QWORD ?
r9Backup QWORD ?
r10Backup QWORD ?
r11Backup QWORD ?
r12Backup QWORD ?
r13Backup QWORD ?
r14Backup QWORD ?
r15Backup QWORD ?

xmm0Backup XMMWORD ?
xmm1Backup XMMWORD ?
xmm2Backup XMMWORD ?
xmm3Backup XMMWORD ?
xmm4Backup XMMWORD ?
xmm5Backup XMMWORD ?
xmm6Backup XMMWORD ?
xmm7Backup XMMWORD ?
xmm8Backup XMMWORD ?
xmm9Backup XMMWORD ?
xmm10Backup XMMWORD ?
xmm11Backup XMMWORD ?
xmm12Backup XMMWORD ?
xmm13Backup XMMWORD ?
xmm14Backup XMMWORD ?
xmm15Backup XMMWORD ?

.code

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

backupRegisters proc frame

mov [raxBackup], rax
mov [rbxBackup], rbx
mov [rcxBackup], rcx
mov [rdxBackup], rdx
mov [rbpBackup], rbp
mov [rsiBackup], rsi
mov [rdiBackup], rdi

mov [r8Backup], r8
mov [r9Backup], r9
mov [r10Backup], r10
mov [r11Backup], r11
mov [r12Backup], r12
mov [r13Backup], r13
mov [r14Backup], r14
mov [r15Backup], r15

movups [xmm0Backup], xmm0
movups [xmm1Backup], xmm1
movups [xmm2Backup], xmm2
movups [xmm3Backup], xmm3
movups [xmm4Backup], xmm4
movups [xmm5Backup], xmm5
movups [xmm6Backup], xmm6
movups [xmm7Backup], xmm7
movups [xmm8Backup], xmm8
movups [xmm9Backup], xmm9
movups [xmm10Backup], xmm10
movups [xmm11Backup], xmm11
movups [xmm12Backup], xmm12
movups [xmm13Backup], xmm13
movups [xmm14Backup], xmm14
movups [xmm15Backup], xmm15

ret

backupRegisters endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

restoreRegisters proc frame

mov rax, [raxBackup]
mov rbx, [rbxBackup]
mov rcx, [rcxBackup]
mov rdx, [rdxBackup]
mov rbp, [rbpBackup]
mov rsi, [rsiBackup]
mov rdi, [rdiBackup]

mov r8, [r8Backup]
mov r9, [r9Backup]
mov r10, [r10Backup]
mov r11, [r11Backup]
mov r12, [r12Backup]
mov r13, [r13Backup]
mov r14, [r14Backup]
mov r15, [r15Backup]

movups xmm0, [xmm0Backup]
movups xmm1, [xmm1Backup]
movups xmm2, [xmm2Backup]
movups xmm3, [xmm3Backup]
movups xmm4, [xmm4Backup]
movups xmm5, [xmm5Backup]
movups xmm6, [xmm6Backup]
movups xmm7, [xmm7Backup]
movups xmm8, [xmm8Backup]
movups xmm9, [xmm9Backup]
movups xmm10, [xmm10Backup]
movups xmm11, [xmm11Backup]
movups xmm12, [xmm12Backup]
movups xmm13, [xmm13Backup]
movups xmm14, [xmm14Backup]
movups xmm15, [xmm15Backup]

ret

restoreRegisters endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

GetRIP proc frame

sub rsp, 08h
call backupRegisters
add rsp, 08h

mov rcx, [rsp]
sub rcx, 0x9
ret

GetRIP endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

ExportHandler proc frame

sub rsp, 28h
call ExportGetRealAddr
call restoreRegisters
add rsp, 28h

jmp [ExportRealAddr]

ExportHandler endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

DllProxyFunction001 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction001 endp

DllProxyFunction002 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction002 endp

DllProxyFunction003 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction003 endp

DllProxyFunction004 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction004 endp

DllProxyFunction005 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction005 endp

DllProxyFunction006 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction006 endp

DllProxyFunction007 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction007 endp

DllProxyFunction008 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction008 endp

DllProxyFunction009 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction009 endp

DllProxyFunction010 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction010 endp

DllProxyFunction011 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction011 endp

DllProxyFunction012 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction012 endp

DllProxyFunction013 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction013 endp

DllProxyFunction014 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction014 endp

DllProxyFunction015 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction015 endp

DllProxyFunction016 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction016 endp

DllProxyFunction017 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction017 endp

DllProxyFunction018 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction018 endp

DllProxyFunction019 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction019 endp

DllProxyFunction020 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction020 endp

DllProxyFunction021 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction021 endp

DllProxyFunction022 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction022 endp

DllProxyFunction023 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction023 endp

DllProxyFunction024 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction024 endp

DllProxyFunction025 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction025 endp

DllProxyFunction026 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction026 endp

DllProxyFunction027 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction027 endp

DllProxyFunction028 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction028 endp

DllProxyFunction029 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction029 endp

DllProxyFunction030 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction030 endp

DllProxyFunction031 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction031 endp

DllProxyFunction032 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction032 endp

DllProxyFunction033 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction033 endp

DllProxyFunction034 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction034 endp

DllProxyFunction035 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction035 endp

DllProxyFunction036 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction036 endp

DllProxyFunction037 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction037 endp

DllProxyFunction038 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction038 endp

DllProxyFunction039 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction039 endp

DllProxyFunction040 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction040 endp

DllProxyFunction041 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction041 endp

DllProxyFunction042 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction042 endp

DllProxyFunction043 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction043 endp

DllProxyFunction044 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction044 endp

DllProxyFunction045 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction045 endp

DllProxyFunction046 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction046 endp

DllProxyFunction047 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction047 endp

DllProxyFunction048 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction048 endp

DllProxyFunction049 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction049 endp

DllProxyFunction050 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction050 endp

DllProxyFunction051 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction051 endp

DllProxyFunction052 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction052 endp

DllProxyFunction053 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction053 endp

DllProxyFunction054 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction054 endp

DllProxyFunction055 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction055 endp

DllProxyFunction056 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction056 endp

DllProxyFunction057 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction057 endp

DllProxyFunction058 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction058 endp

DllProxyFunction059 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction059 endp

DllProxyFunction060 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction060 endp

DllProxyFunction061 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction061 endp

DllProxyFunction062 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction062 endp

DllProxyFunction063 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction063 endp

DllProxyFunction064 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction064 endp

DllProxyFunction065 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction065 endp

DllProxyFunction066 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction066 endp

DllProxyFunction067 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction067 endp

DllProxyFunction068 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction068 endp

DllProxyFunction069 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction069 endp

DllProxyFunction070 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction070 endp

DllProxyFunction071 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction071 endp

DllProxyFunction072 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction072 endp

DllProxyFunction073 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction073 endp

DllProxyFunction074 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction074 endp

DllProxyFunction075 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction075 endp

DllProxyFunction076 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction076 endp

DllProxyFunction077 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction077 endp

DllProxyFunction078 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction078 endp

DllProxyFunction079 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction079 endp

DllProxyFunction080 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction080 endp

DllProxyFunction081 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction081 endp

DllProxyFunction082 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction082 endp

DllProxyFunction083 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction083 endp

DllProxyFunction084 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction084 endp

DllProxyFunction085 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction085 endp

DllProxyFunction086 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction086 endp

DllProxyFunction087 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction087 endp

DllProxyFunction088 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction088 endp

DllProxyFunction089 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction089 endp

DllProxyFunction090 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction090 endp

DllProxyFunction091 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction091 endp

DllProxyFunction092 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction092 endp

DllProxyFunction093 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction093 endp

DllProxyFunction094 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction094 endp

DllProxyFunction095 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction095 endp

DllProxyFunction096 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction096 endp

DllProxyFunction097 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction097 endp

DllProxyFunction098 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction098 endp

DllProxyFunction099 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction099 endp

DllProxyFunction100 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction100 endp

DllProxyFunction101 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction101 endp

DllProxyFunction102 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction102 endp

DllProxyFunction103 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction103 endp

DllProxyFunction104 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction104 endp

DllProxyFunction105 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction105 endp

DllProxyFunction106 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction106 endp

DllProxyFunction107 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction107 endp

DllProxyFunction108 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction108 endp

DllProxyFunction109 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction109 endp

DllProxyFunction110 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction110 endp

DllProxyFunction111 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction111 endp

DllProxyFunction112 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction112 endp

DllProxyFunction113 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction113 endp

DllProxyFunction114 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction114 endp

DllProxyFunction115 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction115 endp

DllProxyFunction116 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction116 endp

DllProxyFunction117 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction117 endp

DllProxyFunction118 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction118 endp

DllProxyFunction119 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction119 endp

DllProxyFunction120 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction120 endp

DllProxyFunction121 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction121 endp

DllProxyFunction122 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction122 endp

DllProxyFunction123 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction123 endp

DllProxyFunction124 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction124 endp

DllProxyFunction125 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction125 endp

DllProxyFunction126 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction126 endp

DllProxyFunction127 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction127 endp

DllProxyFunction128 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction128 endp

DllProxyFunction129 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction129 endp

DllProxyFunction130 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction130 endp

DllProxyFunction131 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction131 endp

DllProxyFunction132 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction132 endp

DllProxyFunction133 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction133 endp

DllProxyFunction134 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction134 endp

DllProxyFunction135 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction135 endp

DllProxyFunction136 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction136 endp

DllProxyFunction137 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction137 endp

DllProxyFunction138 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction138 endp

DllProxyFunction139 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction139 endp

DllProxyFunction140 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction140 endp

DllProxyFunction141 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction141 endp

DllProxyFunction142 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction142 endp

DllProxyFunction143 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction143 endp

DllProxyFunction144 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction144 endp

DllProxyFunction145 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction145 endp

DllProxyFunction146 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction146 endp

DllProxyFunction147 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction147 endp

DllProxyFunction148 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction148 endp

DllProxyFunction149 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction149 endp

DllProxyFunction150 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction150 endp

DllProxyFunction151 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction151 endp

DllProxyFunction152 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction152 endp

DllProxyFunction153 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction153 endp

DllProxyFunction154 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction154 endp

DllProxyFunction155 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction155 endp

DllProxyFunction156 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction156 endp

DllProxyFunction157 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction157 endp

DllProxyFunction158 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction158 endp

DllProxyFunction159 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction159 endp

DllProxyFunction160 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction160 endp

DllProxyFunction161 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction161 endp

DllProxyFunction162 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction162 endp

DllProxyFunction163 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction163 endp

DllProxyFunction164 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction164 endp

DllProxyFunction165 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction165 endp

DllProxyFunction166 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction166 endp

DllProxyFunction167 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction167 endp

DllProxyFunction168 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction168 endp

DllProxyFunction169 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction169 endp

DllProxyFunction170 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction170 endp

DllProxyFunction171 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction171 endp

DllProxyFunction172 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction172 endp

DllProxyFunction173 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction173 endp

DllProxyFunction174 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction174 endp

DllProxyFunction175 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction175 endp

DllProxyFunction176 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction176 endp

DllProxyFunction177 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction177 endp

DllProxyFunction178 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction178 endp

DllProxyFunction179 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction179 endp

DllProxyFunction180 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction180 endp

DllProxyFunction181 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction181 endp

DllProxyFunction182 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction182 endp

DllProxyFunction183 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction183 endp

DllProxyFunction184 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction184 endp

DllProxyFunction185 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction185 endp

DllProxyFunction186 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction186 endp

DllProxyFunction187 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction187 endp

DllProxyFunction188 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction188 endp

DllProxyFunction189 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction189 endp

DllProxyFunction190 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction190 endp

DllProxyFunction191 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction191 endp

DllProxyFunction192 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction192 endp

DllProxyFunction193 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction193 endp

DllProxyFunction194 proc frame

sub rsp, 08h
call GetRIP
add rsp, 08h
jmp ExportHandler

DllProxyFunction194 endp

; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

ENDIF

END