.data
newline:
	.asciz "\n"
mess_s:
	.asciz "Input S:\n"
mess_c:
	.asciz "Input C:\n"
printNuml:
	.asciz "%d\n"
printNum: 
	.asciz "%d "
.bss 
str1:   
	.space 100
substr: 
	.space 10


.global main
.text

sub_string:
	push %ebp
	movl %esp, %ebp
	sub $0x64, %esp
	mov $0, %esi
	mov $0, %edi
	movl 8(%ebp), %ebx
	movl 0x10(%ebp), %eax
	movl %eax, 4(%esp)
	movl 0x14(%ebp), %eax
	movl %eax, 8(%esp)
loop_str:
	leal (%ebx, %esi), %eax
	movl %eax, (%esp)
	call strncmp
	test %eax, %eax
	jne inc_pos
	movl %esi, 12(%esp, %edi,4)
	inc %edi
inc_pos:
	inc %esi
	cmp 12(%ebp), %esi
	jne loop_str
	lea 12(%esp), %ebx
	push %edi
	push $printNuml
	call printf
	movl $-1, %esi
	dec %edi
loop_print:
	inc %esi
	movl (%ebx, %esi,4),%eax
	push %eax
	push $printNum
	call printf
	cmp %edi, %esi
	jl loop_print
	leave
	ret

	
	
main:
	push $mess_s
	call printf
	sub $0x10, %esp
	
	movl $3, %eax
	movl $0, %ebx
	movl $str1, %ecx
	movl $32, %edx
	int $0x80
	
	movl $str1, (%esp)
	movl %eax, 4(%esp)
	push $mess_c
	call printf 
	add $4, %esp
	
	movl $3, %eax
	movl $0, %ebx
	movl $substr, %ecx
	movl $32, %edx
	int $0x80

	movl $substr, 8(%esp)
	dec %eax
	movl %eax, 12(%esp)
	call sub_string
	push $newline
	call printf
exit:   
	mov $1, %eax
	mov $0, %ebx
	int $0x80
	

