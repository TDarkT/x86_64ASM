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
 consoleOutHandle dd ? 
 bytesWritten dd ? 
 message db 'Hello World',0
 lmessage dd ($ - message) - 1

 .code
main PROC
  push STD_OUTPUT_HANDLE
  call GetStdHandle
  mov consoleOutHandle, eax 
  mov edx,offset message    
  mov eax, lmessage
  push 0
  push offset bytesWritten
  push eax
  push edx
  push consoleOutHandle
  call WriteConsoleA
  push 0
  call ExitProcess
  main ENDP
END main