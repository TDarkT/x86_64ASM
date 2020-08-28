.data
message:
	.ascii "Input 2 nums: \0"

formatStr:
	.asciz "%s %s"
printStrl:
	.asciz "Out: %s\n"

ans:
	.fill 100, 1, 0x30
	.byte 0

.bss
num1: 
	.space 100
num2:
	.space 100

	.global main
.text

addLargeNum:
	push %ebp
	mov %esp, %ebp
	movl 0xc(%ebp), %eax
	push %eax
	call strlen
	
	mov %eax, %edi
	dec %edi
	movl 0xc(%ebp), %edx
	movl 0x8(%ebp), %ecx
	push $0
add_loop:
	movzb (%edx,%edi), %ax
	sub $0x30, %ax
	movzb (%ecx,%edi), %bx
	sub $0x30, %bx
	add %bx, %ax
	popl %ebx
	add %bx, %ax
	movb $10, %bl
	divb %bl
	add $0x30, %ah
	movb %ah, (%ecx,%edi)
	and $0xff, %eax
	push %eax
	dec %edi
	cmp $0, %edi
	jge add_loop
	pop %eax
	add $0x30, %eax
	movb %al, (%ecx, %edi)			
	leave
	ret
				
main:
	push %ebp
	movl %esp, %ebp
	push $message
	call printf
	add $4, %esp
	
	push $num2
	push $num1
	push $formatStr
	call scanf
	add $4, %esp
	call strlen
	mov %eax, %ebx
	add $4, %esp
	call strlen
	cmp %eax, %ebx
	jle padnum1
	
	sub %eax, %ebx
	lea ans(%ebx), %eax
	push %eax
	call strcpy
	push $num1
	push $ans
	call addLargeNum
	jmp exit_prog
padnum1:
	sub %ebx, %eax
	lea ans(%eax), %eax
	push $num1
	push %eax
	call strcpy
	push $num2
	push $ans
	call addLargeNum
exit_prog:	
	add $8, %esp
	movl $ans, %eax
	dec %eax
	push %eax
	push $printStrl
	call printf
	add $8,%esp
	leave
	ret  


