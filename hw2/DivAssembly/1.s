WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.equ wordsize, 4
.global my_div, _start
.data
dividend:
.long 0
divisor:
.long 0
quotient:
.long 0
remainder:
.long 0
.text
my_div:# my_div(unsigned int dividend, unsigned int divisor,
#unsigned int* quotient, unsigned int *remainder)
#on entry the stack looks like
#esp + 16: remainder
#esp + 12: quotient
#esp + 8: divisor
#esp + 4: dividend
#esp: return address
#prologue
	push %ebp
	movl %esp, %ebp
	subl $4, %esp
	.equ
	.equ
	.equ
	.equ
	.equ

	ldividend, 2*wordsize #(%ebp)
	ldivisor, 3*wordsize #(%ebp)
	lquotient, 4*wordsize #(%ebp)
	lremainder, 5*wordsize #(%ebp)
	mask, -1*wordsize #(%ebp)

#eax
#ecx
#edx
#ebx
push

	quotient
	remainder
	will be mask
	will be scratch space
	%ebx

	movl $0, %eax #quotient = 0;
	movl $0, %ecx #remainder = 0
	movl $1 << 31, %edx #mask = 1 << 31
#for(; mask > 0; mask >>= 1)
	div_loop:
	cmpl $0, %edx
	jbe end_div_loop
	shll $1, %eax #remainder <<= 1;
	shll $1, %ecx #quotient <<= 1
#if(dividend & mask)
	dividend_is1:
	movl %edx, %ebx
	andl ldividend(%ebp), %ebx
	jz dividend_is_not1
	orl $1, %ecx #remainder |= 1;
	dividend_is_not1:
#if(divisor <= *remainder)

	can_go_in:
	cmpl %ecx, ldivisor(%ebp)
	ja cant_go_in
	subl ldivisor(%ebp), %ecx #remainder -= divisor
	orl $1, %eax #quotient |= 1
	cant_go_in:
	shrl $1, %edx #mask >>= 1
	jmp div_loop
	end_div_loop:
	#set the value of the remainder in memory
	movl lremainder(%ebp), %ebx
	movl %ecx, (%ebx)
	#set the value of the quotient in memory
	movl lquotient(%ebp), %ebx
	movl %eax, (%ebx)
	epilogue:
	pop %ebx
	movl %ebp, %esp
	pop %ebp
	ret
	_start:
#set arguments
	push $remainder
	push $quotient	
	push divisor
	push dividend
#do the division
	call my_div
#clear arguments
	addl $(4*wordsize), %esp
#copy quotient and remainder to eax and edx
	movl quotient, %eax
	movl remainder, %edx
	done:
	movl %eax, %eax
