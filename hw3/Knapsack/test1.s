WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.global knapsack

.text

max:
	.equ wordsize, 4
	.equ a, 2 * wordsize
	.equ b, 3 * wordsize
	
	max_prologue:
	push %ebp
	movl %esp, %ebp
	
	movl a(%ebp), %eax
	movl b(%ebp), %ecx
	
	cmpl %eax, %ecx
	jge returnB
	
	movl %ebp, %esp
	pop %ebp
	ret
	
returnB:
	movl %ecx, %eax
	movl %ebp, %esp
	pop %ebp
	ret
	
knapsack:
	.equ weights, 2 * wordsize
	.equ values, 3 * wordsize
	.equ num_items, 4 * wordsize
	.equ capacity, 5 * wordsize
	.equ cur_value, 6 * wordsize
	
	.equ i, -1 * wordsize
	.equ best_value, -2 * wordsize

#prologue:
	push %ebp
	movl %esp, %ebp
	subl $2 * wordsize, %esp
	push %ebx
	
	movl $0, %ecx # ecx will be i
	
	movl cur_value(%ebp), %eax
	movl %eax, best_value(%ebp) # best_value = cur_value
	movl num_items(%ebp), %edx
	
knap_loop:
	movl num_items(%ebp), %edx #doing subl have to move again
	cmpl %edx, %ecx
	jge end_loop# if i > num_items break
	
	movl capacity(%ebp), %ebx #ebx = capacity
	movl weights(%ebp), %eax # eax = weights
	movl (%eax, %ecx, wordsize), %eax #eax = weights[i]
	
	subl %eax, %ebx #capacity = capacity - weights[i]
	cmpl $0, %ebx 
	jge if_capacity # if capacity > 0
	jmp increaseI#else
	
if_capacity:
	movl values(%ebp), %ebx #ebx = values
	movl (%ebx, %ecx, wordsize), %ebx # ebx  = value[i]
	
	movl cur_value(%ebp), %eax #eax = cur_value
	addl %ebx, %eax
	#cur_value + value[i]
	push %eax
	
	movl weights(%ebp), %eax # eax = weights
	movl (%ebx, %ecx, wordsize), %eax # eax = weights[i]
	movl capacity(%ebp), %ebx #ebx = capacity
	subl %eax, %ebx
	#capacity - weights[i]
	push %ebx
	
	movl num_items(%ebp), %eax #eax = num_items
	subl %ecx, %eax #eax = num_items - i
	decl %eax # ebx = number -i - 1
	#number -i - 1
	push %eax
	
	movl values(%ebp), %eax#eax = value
	leal wordsize(%eax, %ecx, wordsize), %eax #eax = value + i + 1
	#value + i + 1
	push %eax
	
	movl weights(%ebp), %eax #eax = weights
	leal wordsize(%eax, %ecx, wordsize), %eax #eax = weights + i + 1
	#weights + i + 1
	push %eax
	
	movl %ecx, i(%ebp)
	call knapsack
	push %eax #knapsack(weights + i + 1, values + i + 1, num_items - i - 1, capacity - weights[i], cur_value + values[i]))
	movl i(%ebp), %ecx
	addl $5*wordsize, %esp
	
	movl best_value(%ebp), %eax
	push %eax #best_value
	movl i(%ebp), %ecx
	call max
	movl %ecx, i(%ebp)
	
	addl $2*wordsize, %esp
	movl %eax, best_value(%ebp)

increaseI:	
	incl %ecx
	jmp knap_loop

end_loop:

epilogue:
	movl best_value(%ebp), %eax
	pop %ebx
    movl %ebp, %esp 
    pop %ebp
    ret
