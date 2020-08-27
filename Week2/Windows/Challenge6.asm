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
	STDOUT equ 1
	STDIN  equ 0
	

	inputStr BYTE 256 dup (?), 0
	reStr	 BYTE 256 dup (?), 0
	mess	 BYTE "Input: ", 0
	lmess    DWORD ($ - mess)
	formatStr BYTE "%s",0

	.CODE
	reverseStr PROC
		push ebp
		mov ebp, esp
		sub esp, 0ffh
		mov ebx, DWORD PTR [ebp + 8]
		mov edi, DWORD PTR [ebp + 12]
		mov esi, 0
		sub edi, 2
loop_str:
		mov al, BYTE PTR [ebx + edi]
		mov BYTE PTR [esp+esi], al
		inc esi
		dec edi
		cmp edi, 0
		jge loop_str
		inc esi
		mov BYTE PTR [esp+esi], 0
		INVOKE crt_printf, offset formatStr, esp
		leave
		ret
	reverseStr ENDP


	main PROC
		INVOKE crt_printf, offset formatStr, offset mess
		INVOKE crt__read, STDIN, offset inputStr, 256
		push eax
		push offset inputStr
		call reverseStr
		push 0
		call ExitProcess
	main ENDP
end main
