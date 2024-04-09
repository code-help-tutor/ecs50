WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.data
num1:
		.long 23
		.long 233
num2:
		.long 17
		.long 187

.text
.global _start

_start:
		movl $num1, %ebx
		addl (%ebx), %edx
		addl $4, %ebx
		movl (%ebx), %eax
		movl $num2, %ecx
		addl $4, %ecx
		addl (%ecx), %eax
		jnc no_carry
		incl %edx
no_carry:
		addl num2, %edx
done:
	movl %eax, %eax
