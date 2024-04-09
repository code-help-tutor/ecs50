WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.global _start

.data

dividend:
	.long 100

divisor:
	.long 100

.text

_start:
	movl $31, %ecx
	movl $0, %eax
	movl $0, %edx

for_loop:
	movl dividend, %ebx
	shl $1, %edx # remainder <<= 1
	sar %cl, %ebx #dividend >> i
	and $1, %ebx # dividend >> i & 1
	or %ebx, %edx #remainder |= ((dividend >> i) & 1)

	cmpl divisor, %edx
	jge if
	
	decl %ecx
	jge for_loop

	jmp end

if:
	subl divisor, %edx

	movl $1, %edi
	shl %cl, %edi # 1 << i
	
	or %edi, %eax # quotient |= 1 << i;
	decl %ecx
	jge for_loop

end:

done: 
	movl %eax, %eax

