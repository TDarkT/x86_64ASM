
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
	

	mess	 BYTE "Input 2 numbers: ", 0
	formatStr BYTE "%s %s",0
	num1	  BYTE 20 dup (?), 0 
	num2	  BYTE 20 dup (?), 0,0
	ans		  BYTE 21 dup (30h), 0
	.CODE

	addLargeNum PROC
		push ebp
		mov ebp, esp
		mov eax, DWORD PTR [ebp+12]
		push eax
		call crt_strlen
		mov edi, eax
		dec edi
		mov edx, DWORD PTR [ebp+12]
		mov ecx, DWORD PTR [ebp+8]
		push 0
add_loop:		
		movzx ax , BYTE PTR [edx+edi]
		sub ax, 30h
		movzx bx , BYTE PTR [ecx+edi]
		sub bx, 30h
		add ax, bx
		pop ebx
		add ax, bx
		mov bl, 10
		div bl
		add ah, 30h
		mov BYTE PTR [ecx+edi], ah
		and eax, 0ffh
		push eax
		dec edi
		cmp edi, 0
		jge add_loop
		pop eax
		add eax, 30h
		mov BYTE PTR [ecx+edi], al

		leave		
		ret
	addLargeNum ENDP


	main PROC
		
		INVOKE crt_printf, offset mess
		INVOKE crt_scanf, offset formatStr, offset num1, offset num2
		push offset num2
		call crt_strlen
		mov ebx, eax
		push offset num1
		call crt_strlen
		cmp eax, ebx
		jbe pad_num1
pad_num2:		
		sub eax, ebx
		lea eax, [ans+eax]
		push offset num2
		push eax
		call crt_strcpy
		push offset num1
		push offset ans
		call addLargeNum
		jmp ExitP
pad_num1:
		sub ebx, eax
		lea eax, [ans+ebx]
		push offset num1
		push eax
		call crt_strcpy
		push offset num2
		push offset ans
		call addLargeNum
		jmp ExitP
ExitP:
		push offset ans-1
		call crt_printf
		push 0
		call ExitProcess
	main ENDP
end main