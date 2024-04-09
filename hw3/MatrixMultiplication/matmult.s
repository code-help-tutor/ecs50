WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.global matMult
.equ ws, 4

.text

matMult:
#prologue:
	push %ebp
	movl %esp, %ebp
	subl $3 * ws, %esp
	push %ebx

	.equ a, 2 * ws
	.equ num_rows_a, 3 * ws
	.equ num_cols_a, 4 * ws
	.equ b, 5 * ws
	.equ num_rows_b, 6 * ws
	.equ num_cols_b, 7 * ws

	.equ C, -1 * ws
	.equ i, -2 * ws
	.equ sum, -3 * ws

	movl num_rows_a(%ebp), %eax #eax = num_rows_a
	shll $2, %eax #eax = num_rows_a * 4
	push %eax
	call malloc
	addl $1 * ws, %esp #clear args
	#int** C = (int**) malloc( num_rows_a * sizeof(int*))
	movl %eax, C(%ebp) 

	movl $0, %ecx #ecx - i
	i_loop:
		cmpl num_rows_a(%ebp), %ecx
		jge i_loop_end
		movl %ecx, i(%ebp) #store the value
		movl num_cols_b(%ebp), %ecx #ecx = num_cols_b
		shll $2, %ecx #num_cols_b * 4
		push %ecx
		
		call malloc

		addl $1 * ws, %esp
		movl i(%ebp), %ecx #restore the value
		#C[i] = (int*)malloc( num_cols_b * sizeof(int))
		movl C(%ebp), %edx #edx = C
		#edx = C[i]
		movl %eax,(%edx, %ecx, ws) 

		movl $0, %ebx #ebx will be j
	j_loop:
		cmpl num_cols_b(%ebp), %ebx
		jge j_loop_end

		movl $0, %edi #edi will be k
	k_loop:
		cmpl num_rows_b(%ebp), %edi
		jge k_loop_end
 
		movl a(%ebp), %edx #edx = a
		movl (%edx, %ecx, ws), %edx # edx = a[i]
		movl (%edx, %edi, ws), %edx # edx = a[i][k]

		movl b(%ebp), %eax #eax = b
		movl (%eax, %edi, ws), %eax # eax = b[k]
		movl (%eax, %ebx, ws), %eax # eax = b[k][j]

		mull %edx
		addl %eax, sum(%ebp)

		incl %edi
		jmp k_loop

	k_loop_end:
		movl C(%ebp), %edx#edx = C
		movl (%edx, %ecx, ws), %edx #edx = c[i]
	
		movl sum(%ebp), %eax
		movl %eax, (%edx, %ebx, ws)#C[i][j] = sum
		
		movl $0, sum(%ebp)

		incl %ebx
		jmp j_loop
	j_loop_end:
		incl %ecx
		jmp i_loop
	i_loop_end:
		movl C(%ebp), %eax

epilogue:
	pop %ebx
	movl %ebp, %esp
	pop %ebp
	ret




