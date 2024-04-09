WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.equ wordsize, 4 
.globl _start
.data
string1:
	.space 100
string2:
	.space 100
string2_len:
	.long 0

oldDist: 
	.space 100 * wordsize
curDist: 
	.space 100 * wordsize
.text
	init_oldDist:
		movl $0, %ecx
		movl $oldDist, %edi
	fill_oldDist:
		cmpb $0, string2(%ecx) 
		jz end_fill_oldDist
		movl %ecx, (%edi, %ecx, wordsize) 
		incl %ecx 
		jmp fill_oldDist
	end_fill_oldDist:
		movl %ecx, (%edi, %ecx, wordsize) 
		movl %ecx, string2_len
		ret
copy_curDist_to_oldDist:
		movl $curDist, %esi
		movl $oldDist, %edi
		movl string2_len, %ecx
		incl %ecx 
		rep movsl 
		ret
min3: 
first_compare:
		cmpl %esi, %edi 
		jge second_compare 
		movl %edi, %esi
second_compare:
	cmpl %esi, %ebp
	jge return_min3
	movl %ebp, %esi
return_min3:
	ret
_start:
	call init_oldDist 
	movl $1, %eax 
	outer_string_loop: 
	cmpb $0, (string1 - 1)(%eax) 
	jz end_out_string_loop
	movl %eax, curDist
	the length of the current string. curDist[0] = i
	movl $1, %ebx
inner_string_loop: 
	cmpb $0, (string2 - 1)(%ebx) 
	jz end_inner_string_loop
	movb (string2 - 1)(%ebx), %cl
	cmpb (string1 - 1)(%eax), %cl
	jnz diff_char
same_char: 
	movl (oldDist - wordsize)(,%ebx, wordsize), %ecx 
	movl %ecx, curDist(,%ebx, wordsize) 
	jmp end_diff_char
end_same_char:
diff_char:
	movl oldDist(,%ebx,wordsize), %esi
	movl (curDist - wordsize)(,%ebx,wordsize), %edi
	movl (oldDist - wordsize)(, %ebx, wordsize), %ebp
	call min3 
	incl %esi 
	movl %esi, curDist(,%ebx, wordsize)
end_diff_char:
	incl %ebx 
	jmp inner_string_loop
	end_inner_string_loop:
	call copy_curDist_to_oldDist 
	incl %eax 
	jmp outer_string_loop

end_out_string_loop:

movl (curDist - wordsize)(,%ebx, wordsize), %eax

done:
movl %eax, %eax 