    .486                                    ; create 32 bit code
    .MODEL flat, stdcall                    ; 32 bit memory model
    option casemap :none                    ; case sensitive
 
    include \masm32\include\windows.inc     ; always first
    include \masm32\macros\macros.asm       ; MASM support macros

  ; -----------------------------------------------------------------
  ; include files that have MASM format prototypes for function calls
  ; -----------------------------------------------------------------
    include \masm32\include\masm32.inc
    include \masm32\include\gdi32.inc
    include \masm32\include\user32.inc
    include \masm32\include\kernel32.inc
	include \masm32\include\msvcrt.inc

  ; ------------------------------------------------
  ; Library files that have definitions for function
  ; exports and tested reliable prebuilt code.
  ; ------------------------------------------------
    includelib \masm32\lib\masm32.lib
    includelib \masm32\lib\gdi32.lib
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\kernel32.lib
	includelib \masm32\lib\msvcrt.lib
	



 .DATA
	message BYTE 'Input 2 numbers: ', 0
	formatIn BYTE '%d %d', 0
	outStr BYTE 10,'Result: %d',0
	num1 DWORD ?
	num2 DWORD ?

 .CODE
 main PROC
	push offset message
	call crt__cprintf

	sub esp, 12
	mov DWORD PTR [esp], offset formatIn
	mov DWORD PTR [esp+4], offset num1
	mov DWORD PTR [esp+8], offset num2
	call crt__cscanf
	mov eax, DWORD PTR [esp+4]
	mov eax, [eax]
	mov edx, DWORD PTR [esp+8]
	add eax, [edx]

	push eax
	push offset outStr
	call crt__cprintf
	push 0
	call ExitProcess
 main ENDP
END main