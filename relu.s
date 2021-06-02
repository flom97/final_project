.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    # Prologue

    li t0 1            #t0에 1을 load
    li t1 0            #t1에 0을 load
    li t2 0            #t2에 0을 load
    li t3 0            #t3에 0을 load
    li t4 0            #t4에 0을 load


loop_start:

    slli t2 t1 2            #t2=t1*2^2
    add t3 t2 a0            #t3=t2+a0
    add t1 t0 t1            #t1=t0+t1
    beq t1 a1 loop_end            #t1과 a1이 같으면 loop_end로 분기
    lw t4 0(t3)            #t4에 t3의 값을 load
    blt t4 x0 loop_continue            #t4가 x0보다 작으면 loop_continue로 분기
    j loop_start            #loop_start로 점프
    

loop_continue:

    sw x0 0(t3)            #x0에 t3의 값을 저장
    j loop_start            #loop_start로 점프


loop_end:


    # Epilogue

    
	ret
