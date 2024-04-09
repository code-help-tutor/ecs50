WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.global knapsack

.text

max:
#prologue
	push %ebp
	movl %esp, %ebp

	.equ a, 2 * 4
	.equ b, 3 * 4
	
	movl b(%ebp), %eax
		
	cmpl a(%ebp), %eax
	jge returnB #if b > a
	movl a(%ebp), %eax#else eax = a
	
returnB:
#epilogue
	movl %ebp, %esp
	pop %ebp
	ret
	
knapsack:
#prologue:
	push %ebp
	movl %esp, %ebp
	subl $2 * 4, %esp
	
	.equ weights, 2 * 4
	.equ values, 3 * 4
	.equ num_items, 4 * 4
	.equ capacity, 5 * 4
	.equ cur_value, 6 * 4
	
	.equ i, -1 * 4
	.equ best_value, -2 * 4

	push %ebx
	movl $0, %ecx # ecx will be i
	
	movl cur_value(%ebp), %eax
	movl %eax, best_value(%ebp) # best_value = cur_value
	
knap_loop:
	movl num_items(%ebp), %edx #doing subl have to move again
	cmpl %edx, %ecx
	jge end_loop# if i > num_items break
	
	movl capacity(%ebp), %ebx #ebx = capacity
	movl weights(%ebp), %eax # eax = weights
	movl (%eax, %ecx, 4), %eax #eax = weights[i]
	
	subl %eax, %ebx #capacity = capacity - weights[i]
	cmpl $0, %ebx 
	jge if_capacity # if capacity > 0
	jmp increaseI#else just i++ and break the loop
	
if_capacity:
	movl values(%ebp), %edx #edx = values
	movl (%edx, %ecx, 4), %edx # edx  = value[i]
	
	movl cur_value(%ebp), %eax #eax = cur_value
	addl %edx, %eax
	#cur_value + value[i]
	push %eax
	
	movl weights(%ebp), %edx # edx = weights
	movl (%edx, %ecx, 4), %edx # edx = weights[i]
	movl capacity(%ebp), %eax #eax = capacity
	subl %edx, %eax #capacity = capacity -  weights[i]
	#capacity - weights[i]
	push %eax
	
	movl num_items(%ebp), %eax #eax = num_items
	subl %ecx, %eax #eax = num_items - i
	subl $1, %eax # eax = number -i - 1
	#number -i - 1
	push %eax
	
	movl values(%ebp), %eax#eax = value
	leal 4(%eax, %ecx, 4), %eax #eax = value + i + 1
	#value + i + 1
	push %eax
	
	movl weights(%ebp), %eax #eax = weights
	leal 4(%eax, %ecx, 4), %eax #eax = weights + i + 1
	#weights + i + 1
	push %eax
	
	movl %ecx, i(%ebp)#store the value
	call knapsack
	movl i(%ebp), %ecx#ecx get the value
	
	addl $5*4, %esp
	
	push %eax #knapsack(weights + i + 1, values + i + 1, num_items - i - 1, capacity - weights[i], cur_value + values[i]))
	movl best_value(%ebp), %eax
	push %eax #best_value
	
	movl %ecx, i(%ebp)#store the value
	call max
	movl i(%ebp), %ecx#ecx get the value
	addl $2*4, %esp
	movl %eax, best_value(%ebp)

increaseI:	
	incl %ecx
	jmp knap_loop

end_loop:
	movl best_value(%ebp), %eax
epilogue:
	pop %ebx
    movl %ebp, %esp 
    pop %ebp
    ret
