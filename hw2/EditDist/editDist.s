WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.globl _start
.data
string1:
	.space 100
string2:
	.space 100
lengthOfStr2:
	.long 0

old_one: 
	.space 100 * 4
New_one: 
	.space 100 * 4
.text
#esi-pointer of newOne
#edi-pointer of oldOne
min_func: 
		cmpl %esi, %edi # if edi > esi the function will comare esi and ebp
		jge nextt       #else(condition is esi > edi) the esi = edi 
		movl %edi, %esi  
nextt:						
		cmpl %esi, %ebp	 # if ebp > esi, esi is the minmium among three of them return
		jge return		 # else(condition is esi > ebp) esi = ebp
		movl %ebp, %esi
return:
		ret #the function will return esi 

oldOne:
		movl $0, %ecx
		movl $old_one, %edi
set:
		cmpb $0, string2(%ecx) #if str[i]!= None, continue
		jz returnn
		movl %ecx, (%edi, %ecx, 4) 
		incl %ecx 
		jmp set
returnn:
		movl %ecx, (%edi, %ecx, 4) 
		movl %ecx, lengthOfStr2
		ret
swap:
		movl $New_one, %esi
		movl $old_one, %edi
		movl lengthOfStr2, %ecx
		incl %ecx 
		rep movsl 
		ret

_start:
		call oldOne #initialize oldDist
		movl $1, %eax 

loopOutside: 
		cmpb $0, (string1 - 1)(%eax) #make sure this is the end of string 2
		jz end_2
		movl %eax, New_one 
		movl $1, %ebx

Insideloop: 
		cmpb $0, (string2 - 1)(%ebx) 
		jz end_1
		movb (string2 - 1)(%ebx), %cl
		cmpb (string1 - 1)(%eax), %cl
		jnz else
if: 
		movl (old_one - 4)(,%ebx, 4), %ecx 
		movl %ecx, New_one(,%ebx, 4) 
		incl %ebx 
		jmp Insideloop
else:
		movl old_one(,%ebx,4), %esi
		movl (New_one - 4)(,%ebx,4), %edi
		movl (old_one - 4)(, %ebx, 4), %ebp
		call min_func 
		incl %esi 
		movl %esi, New_one(,%ebx, 4)
		incl %ebx 
		jmp Insideloop
end_1:
		call swap 
		incl %eax 
		jmp loopOutside

end_2:
	movl (New_one - 4)(,%ebx, 4), %eax

done:
movl %eax, %eax 
