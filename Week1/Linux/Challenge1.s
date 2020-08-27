.data
message: .ascii "Hello, World!\n"
.text

.globl main 

main:
	movl $4, %eax
	movl $1, %ebx
	movl $message, %ecx
	movl $14, %edx
	int $0x80
exit:
	movl $1, %eax
	movl $0, %ebx
	int $0x80
