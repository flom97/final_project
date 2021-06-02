.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:

    # Prologue

    li t0 0            #t0에 0을 load
    li t1 0            #t1에 0을 load
    li t2 0            #t2에 0을 load
    li t3 0            #t3에 0을 load
    li t4 0            #t4에 0을 load
    li t5 0            #t5에 0을 load


loop_start:

    mul t1 t0 a3            #t1=t0*a3
    mul t2 t0 a4            #t2=t0*a4
    
    slli t1 t1 2            #t1=t1*2^2
    slli t2 t2 2            #t2=t2*2^2
    
    add t3 a0 t1            #t3=a0+t1
    add t4 a1 t2            #t4=a1+t2
    
    add t1 t1 a3            #t1=t1+a3
    add t2 t2 a4            #t2=t2+a4
    
    beq t0 a2 loop_end            #t0과 a2가 같으면 loop_end로 분기
    
    addi t0 t0 1            #t0=t0+1
    
    lw t3 0(t3)            #t3에 t3의 값을 load
    lw t4 0(t4)            #t4에 t4의 값을 load
    mul t3 t3 t4            #t3=t3*t4
    add t5 t5 t3            #t5=t5+t3
    
    j loop_start            #loop_start로 점프


loop_end:


    # Epilogue

    addi a0 t5 0            #a0=t5+0

    ret
