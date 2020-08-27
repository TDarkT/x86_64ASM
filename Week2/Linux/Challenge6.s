.data
message:
	.ascii "Input: \0"

formatStr:
	.asciz "%s"

.bss
input: 
	.space 256

	.global main
.text

reverseStr:
	push %ebp
	mov %esp, %ebp
	sub $0xff, %esp
	movl 0x8(%ebp), %ebx
	movl 0xc(%ebp), %edi
	movl $0, %esi
	sub $2, %edi
	loop_str:
		movb (%ebx, %edi), %al
		movb %al, (%esp,%esi)
		inc %esi
		dec %edi
		cmp $0, %edi
		jge loop_str
	movb $10, (%esp,%esi)
	movb $0, 1(%esp,%esi)
	push %esp
	call printf
	leave
	ret
				
main:
	push %ebp
	movl %esp, %ebp
	
	movl $4, %eax
	movl $1, %ebx
	movl $message, %ecx
	movl $8, %edx
	int $0x80
	
	movl $3, %eax
	movl $0, %ebx
	movl $input, %ecx
	movl $255, %edx
	int $0x80
	push %eax
	push %ecx
	call reverseStr
	leave
	ret  


