.data
message:
	.ascii "Input: \0"

formatNum:
	.asciz "%d"
formatNums:
	.asciz "%d "
.bss
input: 
	.space 256

	.global main
.text

fibonanci:
	push %ebp
	mov %esp, %ebp
	movl 0x8(%ebp), %edi
	push $0
	push $1
fibo_loop:
	push $formatNums
	call printf
	pop %edx
	pop %ebx
	pop %eax
	add %ebx, %eax
	push %ebx
	push %eax
	dec %edi
	cmp $0, %edi
	jne fibo_loop
	
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
	push %esp
	push $formatNum
	call scanf
	add $8, %esp
	call fibonanci
	leave
	ret  


