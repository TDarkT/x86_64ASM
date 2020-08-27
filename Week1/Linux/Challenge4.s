.data
message:
	.ascii "Input 2 numbers: \0"
input: 
	.asciz "%d %d"
output: 
	.asciz "Result: %d\n"
	.global main
.text
main:
	push $message
	call printf
	sub $12, %esp
	lea 8(%esp), %eax
	mov %eax, 8(%esp)
	lea 4(%esp), %eax
	mov %eax, 4(%esp)
	movl $input, (%esp)
	call scanf
	mov 8(%esp), %eax
	add 4(%esp), %eax
	push %eax
	push $output
	call printf
	jmp exit
  
exit:   
	mov $1, %eax
	mov $0, %ebx
	int $0x80
	

