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
	push %edi
	push %esi
	
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
		movl num_cols_b(%ebp), %eax #eax = num_cols_b
		shll $2, %eax #num_cols_b * 4
		push %eax
		
		movl %ecx, i(%ebp) #store the value
		call malloc
		movl i(%ebp), %ecx #restore the value
		
		addl $1 * ws, %esp
		#C[i] = (int*)malloc( num_cols_b * sizeof(int))
		movl C(%ebp), %ebx #ebx = C
		#ebx = C[i]
		movl %eax,(%ebx, %ecx, ws) 
		movl $0, sum(%ebp)
		movl $0, %edx #edx will be j
	j_loop:
		cmpl num_cols_b(%ebp), %edx
		jge j_loop_end

		movl $0, %edi #edi will be k
	k_loop:
		cmpl num_rows_b(%ebp), %edi
		jge k_loop_end

		movl a(%ebp), %ebx #ebx = a
		movl (%ebx, %ecx, ws), %ebx # ebx = a[i]
		movl (%ebx, %edi, ws), %ebx # ebx = a[i][k]

		movl b(%ebp), %eax #eax = b
		movl (%eax, %edi, ws), %eax # eax = b[k]
		movl (%eax, %edx, ws), %eax # eax = b[k][j]

		mull %ebx
		addl %eax, sum(%ebp)

		incl %edi
		jmp k_loop

	k_loop_end:
		movl C(%ebp), %eax#eax = C
		movl (%eax, %ecx, ws), %eax #eax = c[i]
		movl sum(%ebp), %esi
		movl %esi, (%eax, %edx, ws)#C[i][j] = sum
		movl $0, sum(%ebp)
		incl %edx
		jmp j_loop
	j_loop_end:
		incl %ecx
		jmp i_loop
	i_loop_end:
		movl C(%ebp), %eax

epilogue:
	pop %esi
	pop %edi
	pop %ebx
	movl %ebp, %esp
	pop %ebp
	ret




