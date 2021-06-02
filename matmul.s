.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error if mismatched dimensions


    # Prologue

    bne a2 a4 mismatched_dimensions            #a2와 a4가 같지 않으면 mismatched_dimensions로 분기

    li t0 0            #t0에 0을 load
    li t1 0            #t1에 0을 load
    li t2 0            #t2에 0을 load
    li t3 0            #t3에 0을 load
    li t4 0            #t4에 0을 load
    li t5 0            #t5에 0을 load
    li t6 0            #t6에 0을 load


outer_loop_start:

    mul t4 t0 a2            #t4=t0*a2


inner_loop_start:

    add t5 t4 t1            #t5=t4+t1
    slli t5 t5 2            #t5=t5*2^2
    add t5 t5 a0            #t5=t5+a0
    lw t5 0(t5)            #t5에 t5의 값을 load
    
    mul t6 t1 a5            #t6=t1*a5
    add t6 t6 t3            #t6=t6+t3
    slli t6 t6 2            #t6=t6*2^2
    add t6 t6 a3            #t6=t6+a3
    lw t6 0(t6)            #t6에 t6의 값을 load
    
    mul t5 t5 t6            #t5=t5*t6
    add t2 t2 t5            #t2=t2+t5
    
    addi t1 t1 1            #t1=t1+1
    bne t1 a4 inner_loop_start            #t1과 a4가 같지 않으면 inner_loop_start로 분기
    
    sw t2 0(a6)            #t2에 a6의 값을 저장
    addi a6 a6 4            #a6=a6+4
    
    addi t3 t3 1            #t3=t3+1
    li t2 0            #t2에 0을 load
    li t1 0            #t1에 0을 load
    bne t3 a5 inner_loop_start            #t3와 a5가 같지 않으면 inner_loop_start로 분기


inner_loop_end:

    li t3 0            #t3에 0을 load
    addi t0 t0 1            #t0=t0+1
    bne t0 a1 outer_loop_start            #t0와 a1이 같지 않으면 outer_loop_start로 분기
    

outer_loop_end:


    # Epilogue
    
    mul t0 a1 a5            #t0=a1*a5
    slli t0 t0 2            #t0=t0*2^2
    li t1 -1            #t1에 -1을 load
    mul t0 t0 t1            #t0=t0*t1
    add a6 a6 t0            #a6=a6+t0

    ret


mismatched_dimensions:

    li a1 2            #a1에 2를 load
    jal exit2            
