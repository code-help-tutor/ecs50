WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
global _start


.data

dividend:
    .long 0

divisor:
    .long 0

.text

_start:
	movl %ecx, $31

	movl $dividend, %esi #tmp value
	movl $0, %ecn #count of bits
	movl $0, %eax #dividend
	movl $0, %edx #reminder

loop1:
	incl %ecn
	cmpl $0, %esi
	jz getcount
	shr $1, %esi
	decl %ecn
	jnz loop1

getcount:
	decl %ecn
	jmp loop2

loop2:
	movl $dividend, %ebx
	shl %edx, $1 # remainder << 1
	sar %ebx, %ecn # dividend >> i
	and %ecn, $1 #(dividend >> i) & 1
	or %ecn, %edx #(reminder |= (dividend >> i) & 1)

	movl divisor, %ebp #tmp value for disvisor
	subl %edx, %ebp #divisor - reminder
	jle if2 # result <= 0 goto if2
	decl %ecx#if not i--
	jge loop2#continue to loop
			#if not loop done	
	jmp done

if2:
	subl $disvisor, %edx #reminder - divisor
	sal $1, %ecn # 1 << i
	or %ecn, %eax # quotient |= 1 << i


	


