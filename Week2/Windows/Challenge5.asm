    .486                                    ; create 32 bit code
    .model flat, stdcall                    ; 32 bit memory model
    option casemap :none                    ; case sensitive
 
    include \masm32\include\windows.inc     ; always first
    include \masm32\macros\macros.asm       ; MASM support macros
  ;	include \masm32\include\masm32rt.inc
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

 .data
 consoleInHandle  DD ?
 consoleOutHandle DD ? 
 bytesWritten	  DD ?
 bytesRead		  DD ?
 str1			  BYTE 100 dup (?)
 substr1		  BYTE 10 dup (?)
 in_mess_s		  BYTE "Input S: ", 0
 in_mess_c		  BYTE "Input C: ", 0
 lmessage		  DD ($ - in_mess_c) - 1
 numlprint			  BYTE "%d",10, 0
 numprint			  BYTE "%d ", 0
 .code
 sub_string_count PROC
	push ebp
	mov ebp, esp
	sub esp, 64h
	mov esi, 0
	mov edi, 0
	mov ebx, DWORD PTR [ebp+8h]
	mov eax, DWORD PTR [ebp+10h]
	mov DWORD PTR [esp+4], eax
	mov eax, DWORD PTR [ebp+14h]
	mov DWORD PTR [esp+8], eax
	
loop_str:
	
	lea eax, [ebx+esi]
	mov DWORD PTR [esp], eax
	call crt_strncmp
	test eax,eax
    jne inc_pos
	mov DWORD PTR [esp+4*edi+12],esi
	inc edi
inc_pos:
	inc esi
	cmp esi, DWORD PTR [ebp+0ch]
	jne loop_str

	lea ebx, [esp+12]
	INVOKE crt_printf, offset numlprint, edi
    mov esi, -1
	dec edi
loop_print:
    inc esi
	mov eax, DWORD PTR [ebx + 4*esi]
	INVOKE crt_printf, offset numprint, eax
	cmp esi, edi
	jl loop_print

	leave
	ret
 sub_string_count ENDP 

main PROC
  INVOKE GetStdHandle, STD_OUTPUT_HANDLE
  mov DWORD PTR [consoleOutHandle], eax 
  INVOKE GetStdHandle, STD_INPUT_HANDLE
  mov DWORD PTR [consoleInHandle], eax 
  
  sub esp, 10h
  mov edx,offset in_mess_s    
  mov eax, bytesWritten
  INVOKE WriteConsole, consoleOutHandle, edx, lmessage, eax, 0
	
  mov eax, offset bytesRead
  mov edx, offset str1
  INVOKE ReadConsole, consoleInHandle, edx, 100, eax, 0	

  mov eax, offset str1
  mov DWORD PTR [esp], eax
  mov eax, DWORD PTR [bytesRead]
  mov DWORD PTR [esp + 4], eax
  
  mov edx,offset in_mess_c   
  mov eax, bytesWritten
  INVOKE WriteConsole, consoleOutHandle, edx, lmessage, eax, 0
	
  mov eax, offset bytesRead
  mov edx, offset substr1
  INVOKE ReadConsole, consoleInHandle, edx, 10, eax, 0	
  
  mov eax, offset substr1
  mov DWORD PTR [esp + 8], eax
  mov eax, DWORD PTR [bytesRead]
  sub eax, 2
  mov DWORD PTR [esp + 12], eax
 
  call sub_string_count
  
  push 0
  call ExitProcess
  main ENDP

END main