
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
	

	mess	 BYTE "Input N: ", 0
	formatStr BYTE "%s",0
	formatNum BYTE "%d",0
	formatNum1 BYTE "%d ",0
	fibo	  DWORD 100 dup (?) 
	.CODE
	fibonanci PROC
		push ebp
		mov ebp, esp
		mov ebx, offset fibo
		mov edi, DWORD PTR [ebp + 8]
		sub edi, 2
		mov esi, 0
fibo_loop:
		mov eax, DWORD PTR [fibo + 4*esi]
		add eax, DWORD PTR [fibo + 4*esi + 4]
		mov DWORD PTR [fibo + 4*esi + 8],eax
		INVOKE crt_printf, offset formatNum1, eax
		inc esi
		cmp esi, edi
		jne fibo_loop
		leave		
		ret
	fibonanci ENDP


	main PROC
		mov DWORD PTR [fibo], 1
		mov DWORD PTR [fibo + 4], 1

		INVOKE crt_printf, offset formatStr, offset mess
		sub esp, 4
		mov eax, esp
		INVOKE crt_scanf, offset formatNum, eax
		INVOKE crt_printf, offset formatNum1, offset 1
		INVOKE crt_printf, offset formatNum1, offset 1
		call fibonanci

		push 0
		call ExitProcess
	main ENDP
end main
