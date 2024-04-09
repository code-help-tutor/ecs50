WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
#this program calcualtes the edit distance between 2 strings
#the maximum length of each string is 100 characters including the NULL character
#the final edit distance should be placed in EAX
.equ wordsize, 4 #the size of each word is 4 bytes
.globl _start
.data
string1:
	.space 100
string2:
	.space 100
string2_len:
	.long 0

oldDist: #contains the edit distance from the previous iteration
	.space 100 * wordsize
curDist: #contains the edit distance fom the current iteration
	.space 100 * wordsize
.text
	init_oldDist:
#initializes oldDist and stores the length of string2 in string2_len
#ecx will hold the current count
#edi will hold the pointer to oldDist
#first step is to fill up the previous distance vector with a count
		movl $0, %ecx
		movl $oldDist, %edi
	fill_oldDist:
		cmpb $0, string2(%ecx) #check for end of string
		jz end_fill_oldDist
		movl %ecx, (%edi, %ecx, wordsize) #mov the count to oldDist
		incl %ecx #increment counter
		jmp fill_oldDist
	end_fill_oldDist:
		movl %ecx, (%edi, %ecx, wordsize) #mov the count to oldDist
		movl %ecx, string2_len
		ret
copy_curDist_to_oldDist:
#esi will be the pointer to curDist
#edi will be the pointer to oldDist
#ecx will be the counter
		movl $curDist, %esi
		movl $oldDist, %edi
		movl string2_len, %ecx
		incl %ecx #the lengths of the distance arrays are 1 longer then the length of string2
		rep movsl #copy curDist to oldDist
		ret
min3: #finds the min of ESI, EDI, EBP
#if(edi < esi)
#esi = edi
#if(ebp < esi)
#esi = ebp
#return esi
first_compare:

  cmpl %esi, %edi #edi < esi == edi - esi < 0.
		jge second_compare #negation is edi - esi >= 0
		movl %edi, %esi
second_compare:
#ebp < esi == ebp - esi < 0
	cmpl %esi, %ebp
#negation is ebp - esi >= 0
	jge return_min3
	movl %ebp, %esi
return_min3:
	ret
_start:
#eax will hold the outer counter, i
#ebx will hold the inner counter, j
#ecx will be used to hold temproray values
	call init_oldDist #initialize oldDist
	movl $1, %eax #init
	outer_string_loop: #the beginning loop over string1
	cmpb $0, (string1 - 1)(%eax) #check if we reached the end of string1
	jz end_out_string_loop #if so finish the outer for loop
	movl %eax, curDist #this is the part where we initialize the column with
	the length of the current string. curDist[0] = i
	movl $1, %ebx
inner_string_loop: #beginning of the loop over string2
	cmpb $0, (string2 - 1)(%ebx) #check if we have reached the end of
	string2
	jz end_inner_string_loop #if so finish the inner for loop
	movb (string2 - 1)(%ebx), %cl
	cmpb (string1 - 1)(%eax), %cl #is string1[i-1] == string2[j-1]?
	jnz diff_char
same_char: #if string1[i] == string2[j]
	movl (oldDist - wordsize)(,%ebx, wordsize), %ecx #place
	oldDist[j-1] in EDX
	movl %ecx, curDist(,%ebx, wordsize) #curDist[j] = oldDist[j-1]
	jmp end_diff_char
end_same_char:
diff_char:
#prepare for call to min3
	movl oldDist(,%ebx,wordsize), %esi #deletion. oldDist[j]
	movl (curDist - wordsize)(,%ebx,wordsize), %edi
#insertion. curDist[j-1]
	movl (oldDist - wordsize)(, %ebx, wordsize), %ebp
#substitution. oldDist[j-1]
	call min3 #make the call
	incl %esi #we made a change so add 1 to the cost
	movl %esi, curDist(,%ebx, wordsize) #curDist[j] =
	min(oldDist[j], curDist[j-1], oldDist[j-1]) + 1
end_diff_char:
	incl %ebx #j++
	jmp inner_string_loop
	end_inner_string_loop:
	call copy_curDist_to_oldDist #do the copy
	incl %eax #i++
	jmp outer_string_loop

end_out_string_loop:
#ebx is 1 beyond the end of curDist
movl (curDist - wordsize)(,%ebx, wordsize), %eax

done:
movl %eax, %eax #this line doesn't do anything