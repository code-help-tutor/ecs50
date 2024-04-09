WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
.global get_combs

.text

get_combs:

    push %ebp
    movl %esp, %ebp
    subl $5 * 4, %esp 

    .equ items, 2 * 4
    .equ k,3 * 4
    .equ len, 4 * 4

    .equ combs, -1 * 4 
    .equ current, -2 * 4 
    .equ matrix, -3 * 4  
    .equ row, -4 * 4  
    .equ iterator, -5 * 4

    movl $0, row(%ebp)

    push k(%ebp)
    push len(%ebp)
    call num_combs
    addl $(2*4), %esp #clear args
    movl %eax, combs(%ebp)
    #Initialization:int** matrix = (int**)malloc(combs * sizeof(int*))
    shll $2, %eax
    push %eax
    call malloc
    add $(1*4), %esp
    movl %eax, matrix(%ebp)
    
    #int* current = (int*)malloc(k *sizeof(int));
    movl k(%ebp), %edx
    shll $2, %edx
    push %edx
    call malloc
    addl $(1*4), %esp#clear args
    movl %eax, current(%ebp)
    
    movl $0, %ecx
    loop: 
        #Initialization: matrix[i] = (int*)malloc(k * sizeof(int))
        movl k(%ebp), %eax# k*sizeof(int)
        shll $2, %eax #k*sizeof(int)
        push %eax
        movl %ecx, iterator(%ebp)
        call malloc 
        movl iterator(%ebp), %ecx
        addl $(1*4), %esp#clear args
        movl matrix(%ebp), %edx
        movl %eax, (%edx, %ecx, 4);

        incl %ecx
        cmpl combs(%ebp), %ecx
        jl loop
        
        #recurion(k,k,len,current,items,&row,matrix);
    loop_end:
        #matrix
        movl matrix(%ebp), %eax
        push %eax

        #row
        leal row(%ebp), %eax 
        push %eax
        
        #items
        push items(%ebp)

        #current
        push current(%ebp)
        
        #len
        push len(%ebp)
        
        push k(%ebp)
        push k(%ebp)

        call recursionPart
        
        addl $7 * 4, %esp #clear args

    free_func:
        push current(%ebp)
        call free
    #epilogue:
        movl matrix(%ebp), %eax
        movl %ebp, %esp
        pop %ebp
        ret

recursionPart:
    prologue:
        push %ebp
        movl %esp, %ebp
        subl $1 * 4, %esp
        push %ebx
        push %edi

        .equ k, 2 * 4
        .equ cols, 3 * 4
        .equ len, 4 * 4
        .equ current, 5 * 4
        .equ items, 6 * 4
        .equ row, 7 * 4
        .equ matrix, 8 * 4
        
        .equ iterator, -1 * 4
        #void recursion(int k, int cols,int len,int* current,int* items,int* row, int** matrix){
        #if(k == 0)
        #{
        #    for(int i = 0; i < cols; ++i)
        #        matrix[*row][i] = current[i];
        #    (*row)++;
        #}
        #else
        #    for(int i = 0; i < len; i++)
        #    {
        #    current[cols - k] = items[i];
        #    recursion(k - 1, cols, len - i - 1,current,items + i + 1,row,matrix);
        #    }      

        if: 
            cmpl $0, k(%ebp)
            jnz Recursive
            
            movl $0, %ecx
            if_for_loop:# this is for(int i = 0; i < cols; ++i)
                cmpl cols(%ebp), %ecx
                jge if_end
                #Initialization: matrix[*row][i] = current[i]
                
                movl current(%ebp), %edi
                movl (%edi,%ecx,4), %edi #current[i]

                movl row(%ebp), %ebx
                movl (%ebx), %ebx #dereference 
               
                movl matrix(%ebp), %edx 
                movl (%edx,%ebx,4), %eax 
                
                movl %edi, (%eax,%ecx,4) #matrix[*row][i] = current[i];

                incl %ecx
                jmp if_for_loop

            if_end:
                movl row(%ebp), %eax
                incl (%eax)
                jmp final_end

        Recursive:
            movl $0, %ecx
            recursiveLoop:
                cmpl len(%ebp), %ecx
                jge final_end

                movl items(%ebp), %eax
                movl (%eax, %ecx, 4), %eax
                movl cols(%ebp), %edx
                subl k(%ebp), %edx  #edx = cols - k
                movl current(%ebp), %ebx 
                movl %eax, (%ebx, %edx, 4)  #Initialization:  current[cols - k] = items[i]
                #recursion(k - 1, cols, len - i - 1,current,items + i + 1,row,matrix);
                #matrix               
                push matrix(%ebp)
               
                #row
                push row(%ebp)

                #items + i + 1
                movl items(%ebp), %ebx
                leal 4(%ebx, %ecx, 4), %eax #eax = i+ +1 + items
                push %eax
                
                #current 
                push current(%ebp)

                #len - i - 1
                movl len(%ebp), %eax
                subl %ecx, %eax
                subl $1, %eax 
                push %eax

                #cols
                push cols(%ebp)

                #k - 1
                movl k(%ebp), %edi
                subl $1, %edi 
                push %edi
                movl %ecx, iterator(%ebp)
                call recursionPart
                
                addl $(7 * 4), %esp 
                movl iterator(%ebp), %ecx
                incl %ecx

                jmp recursiveLoop
    final_end:
        
    epiologue:
        pop %edi
        pop %ebx
        movl %ebp, %esp
        pop %ebp
        ret
