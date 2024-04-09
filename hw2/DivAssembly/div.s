WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.equ count, 32
	
.data

dividend :
	.long 1

divisor :
	.long 0

remainder :
	.long 0

quotient :
	.long 30

i:
	.long 31

.text

.globl _start
_start:
	movl dividend, %eax
	movl $dividend, %ebn
	movl (%ebn), %ecx
	movl divisor, %edi
	movl remainder, %ecx
	movl quotient, %edx             
        movl i, %esi
	movl $0, %ebx   
                             
for_start:
        incl %ebx
        cmpl $0, %eax
        jz count_get
        shr $1, %eax
        decl %esi
        jnz for_start

Exceed_mamimum:
	movl %edx, %ebx
        jmp second_for_start

count_get: 
	decl %ebx
	movl %ebn, %eax
	movl $0, %edx
	jmp second_for_start

second_for_start:
	
        movl %ecx, %esi
        movl %ebx, %ecx	
	shl  $1, %esi
	shr %cl, %eax
	movl %esi, %ecx
	and $1, %eax
	movl %eax, %esi
    movl %ebn, %eax
	shl $0, %esi
	or %esi, %ecx
	cmpl %edi, %ecx
	jge ifstatement
	decl %ebx
	jge second_for_start

last_step:         
	movl %edx, %eax
	movl %ecx, %edx
	jmp done

ifstatement:
	subl %edi, %ecx
	pushl %edi
        pushl %ecx
	movl $1, %edi
	movl %ebx, %ecx
	shl  %cl, %edi
	or %edi, %edx
	popl %ecx
	popl %edi
	decl %ebx
	jmp second_for_start

done:   movl %edi, %edi