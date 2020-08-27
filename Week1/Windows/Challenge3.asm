    .486                                    ; create 32 bit code
    .model flat, stdcall                    ; 32 bit memory model
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

  ; ------------------------------------------------
  ; Library files that have definitions for function
  ; exports and tested reliable prebuilt code.
  ; ------------------------------------------------
    includelib \masm32\lib\masm32.lib
    includelib \masm32\lib\gdi32.lib
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\kernel32.lib

 .DATA
	message BYTE 'Your input:', 0
	lmessage DWORD ($ - message) - 1
	
	consoleInHandle DWORD ?
	consoleOutHandle DWORD ? 
	bytesRead DWORD ? 
	bytesWritten DWORD ? 
	str1 BYTE 32 dup (?)
	

 .CODE
	main PROC
	; Get IO handle	
	  INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	  mov consoleOutHandle, eax 
	  INVOKE GetStdHandle, STD_INPUT_HANDLE
	  mov consoleInHandle, eax

	; Print promt message 
	  mov edx,offset message    
	  mov eax, bytesWritten
	  INVOKE WriteConsole, consoleOutHandle, edx, lmessage, eax, 0
	
	; Read input
	  mov eax, offset bytesRead
	  mov edx, offset str1
	  INVOKE ReadConsole, consoleInHandle, edx, 32, eax, 0

	; Convert input string to uppercase  
	  mov eax, offset str1
	  mov edi, bytesRead 
	  mov esi, 0	
	upper_case:
	  mov bl, BYTE PTR [eax+esi]
	  cmp bl, 7ah
	  jg inc_index
	  cmp bl, 61h
	  jb inc_index
	  sub BYTE PTR [eax+esi], 20h
	inc_index:
	  inc esi
	  cmp edi, esi
	  jne upper_case
	  
	  mov edx,offset str1    
	  mov eax, bytesWritten
	  INVOKE WriteConsole, consoleOutHandle, edx, bytesRead, eax, 0 
	
	  INVOKE ExitProcess, 0
	  main ENDP
	END main