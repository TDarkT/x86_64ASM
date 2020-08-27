	.data
message:
	.asciz "Input: "
	len = . - message 
strin: 
	.space 32

	.global _main
	.text
_main:
		#print prompt msg 
	mov $4, %eax
	mov $1, %ebx
	movl $message, %ecx
	movl $len, %edx
	int $0x80
		#read user input
	mov $3, %eax
	mov $0, %ebx
	movl $strin, %ecx
	movl $32, %edx
	int $0x80

	movl %eax, %edi
	mov $0, %esi
_loop:
	movb strin(%esi), %bl
	cmp $0x61, %bl
	jb check 
	cmp $0x7a, %bl
	jg check
	sub $0x20, %bl
	movb %bl, strin(%esi)
check:	
	inc %esi
	cmp %edi, %esi
	jne _loop
	
		#print user's input string
	movl %eax, %edx
	mov $1, %ebx
	movl $strin, %ecx
	mov $4, %eax
	int $0x80

exit:   
	mov $1, %eax
	mov $0, %ebx
	int $0x80
	

