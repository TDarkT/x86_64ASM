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

 .data
 message db 'Your input:', 0
 lmessage dd ($ - message) - 1
 
 consoleInHandle dd ?
 consoleOutHandle dd ? 
 bytesRead dd ? 
 bytesWritten dd ? 
 str1 db 32 dup (?)
 

 .code
main PROC

  push STD_OUTPUT_HANDLE
  call GetStdHandle
  mov consoleOutHandle, eax 
  push STD_INPUT_HANDLE
  call GetStdHandle
  mov consoleInHandle, eax
  
  mov edx,offset message    
  mov eax, lmessage
  push 0
  push offset bytesWritten
  push eax
  push edx
  push consoleOutHandle
  call WriteConsoleA
;read
  mov eax, 32
  mov edx, offset str1
  push 0
  push offset bytesRead
  push eax
  push edx
  push consoleInHandle
  call ReadConsole
  push 0
  
  mov edx,offset str1    
  mov eax, bytesRead
  push 0
  push offset bytesWritten
  push eax
  push edx
  push consoleOutHandle
  call WriteConsoleA

  call ExitProcess
  main ENDP
END main