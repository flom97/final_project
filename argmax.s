.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:

    # Prologue

    li t0 0            #t0에 0을 load
    li t3 0            #t3에 0을 load


loop_start:


    slli t1 t0 2            #t1=t0*2^2
    add t1 t1 a0            #t1=t1+a0
    lw t2 0(t1)            #t2에 t1의 값을 load

    beq t0 a1 loop_end            #t0과 a1이 같으면 loop_end로 분기
    blt t3 t2 loop_continue            #t3가 t2보다 작으면 loop_continue로 분기

    addi t0 t0 1            #t0=t0+1
    j loop_start            #loop_start로 점프


loop_continue:


    addi t4 t0 0            #t4=t0+0   
    add t3 t2 x0            #t3=t2+x0   
    j loop_start            #loop_start로 점프


loop_end:
    

    # Epilogue

    addi a0 t4 0            #a0=t4+x0

    ret
