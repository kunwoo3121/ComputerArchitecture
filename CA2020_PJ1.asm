# -------------------------------------------------------------------
# [KNU COMP411 Computer Architecture] Skeleton code for the 1st project (calculator)
# -------------------------------------------------------------------
.data
input_String: .space 24

.text	
# main
main:
	
	#jal x1, test #functionality test, Do not modify!!
	
	#----TODO-------------------------------------------------------------
	#1. read a string from the console
	#2. perform arithmetic operations
	#3. print a string to the console to show the computation result
	#----------------------------------------------------------------------
	Console_io_Loop:		#콘솔 입력 받기 시작 
	li   a7, 11
	addi a0, zero, 62
	ecall

	li   a7, 8
	la   a0, input_String
	addi a1, zero, 100
	ecall 
	
	addi t2, zero, 0
	addi t4, zero, 10
	addi t5, zero, 0		#입력된 -가 부호인지 연산자인지 판단하기 위한 레지스터 
	addi t6, zero, 0		#입력되고 있는 숫자가 음수인지 양수인지 판단하기 위한 레지스터 
	
	add  a2, zero, zero
	add  a3, zero, zero
	
	input_Loop:			#입력 받은 String, Operand와 Operation 분리 
	lb   t0, 0(a0)
	addi t1, zero, 0x71
	beq  t0, t1, Console_io_exit 	#q가 입력될 경우 프로그램 종료
	addi t1, zero, 0x0a
	beq  t0, t1, input_Loop_exit
	make_op_add:			
	addi t1, zero, 0x2b
	bne  t0, t1, make_op_sub
	addi t5, zero, -1
	addi a1, zero, 0
	addi t2, zero, 1
	add  a6, zero, t1
	add  t6, zero, zero
	beq  zero, zero, pass
	make_op_sub:
	addi t1, zero, 0x2d
	bne  t0, t1, make_op_mul
	bne  t5, zero, real_op
	addi t6, zero, 1
	beq  zero, zero, pass
	real_op:
	addi t5, zero, -1
	addi a1, zero, 1
	addi t2, zero, 1
	add  a6, zero, t1
	add  t6, zero, zero
	beq  zero, zero, pass
	make_op_mul:
	addi t1, zero, 0x2a
	bne  t0, t1, make_op_div
	addi t5, zero, -1
	addi a1, zero, 2
	addi t2, zero, 1
	add  a6, zero, t1
	add  t6, zero, zero
	beq  zero, zero, pass
	make_op_div:
	addi t1, zero, 0x2f
	bne  t0, t1, make_operand1
	addi t5, zero, -1
	addi a1, zero, 3
	addi t2, zero, 1
	add  a6, zero, t1
	add  t6, zero, zero
	beq  zero, zero, pass
	make_operand1:
	addi t1, zero, 0
	bne  t2, t1, make_operand2
	addi  t0, t0, -48
	beq  t6, zero, not_negative1 
	xori t0, t0, 0xFFFFFFFF
	addi t0, t0, 1
	not_negative1:
	mul  a2, a2, t4
	add  a2, a2, t0
	make_operand2:
	addi t1, zero, 0
	beq  t2, t1, pass
	addi  t0, t0, -48
	beq  t6, zero, not_negative2 
	xori t0, t0, 0xFFFFFFFF
	addi t0, t0, 1
	not_negative2:
	mul  a3, a3, t4
	add  a3, a3, t0
	pass:
	addi a0, a0, 1
	addi t5, t5, 1
	beq  zero, zero, input_Loop
	
	input_Loop_exit:
	jal  ra, calc
	
	add  t0, a0, zero
	
	li   a7, 1
	add  a0, zero, a2
	ecall
	
	li   a7, 11
	add  a0, zero, a6
	ecall
	
	li   a7, 1
	add  a0, zero, a3
	ecall
	
	li   a7, 11
	addi a0, zero, 61		
	ecall
	
	li   a7, 1
	add  a0, zero, t0
	ecall
	
	addi t1, zero, 0x2f 
	bne  a6, t1, not_division
	
	li   a7, 11
	addi a0, zero, 44
	ecall
	
	li   a7, 1
	add  a0, zero, a4
	ecall
	
	not_division:
	li   a7, 11
	addi a0, zero, 10		
	ecall
	
	beq zero, zero, Console_io_Loop
	
	Console_io_exit:
	# Exit (93) with code 0
        li a0, 0
        li a7, 93
        ecall
        ebreak

#----------------------------------
#name: calc
#func: performs arithmetic operation
#x11(a1): arithmetic operation (0: addition, 1:  subtraction, 2:  multiplication, 3: division)
#x12(a2): the first operand
#x13(a3): the second operand
#x10(a0): return value
#x14(a4): return value (remainder for division operation)
#----------------------------------
calc:
	
	#TODO
	addi t0, zero, 0
	bne  t0, a1, calc_sub
	calc_add:
	add  a0, a2, a3
	beq  zero, zero, calc_end
	calc_sub:
	addi t0, zero, 1
	bne  t0, a1, calc_mul
	xori t3, a3, 0xFFFFFFFF
	addi t3, t3, 1
	add  a0, a2, t3
	beq  zero, zero, calc_end
	calc_mul:
	addi t0, zero, 2
	bne  t0, a1, calc_div
	add  t3, zero, a2
	add  t4, zero, a3
	add  a0, zero, zero
	calc_mul_loop:
	andi t5, t4, 1
	addi t6, zero, 1
	bne  t5, t6,lsb_not_1 
	add  a0, a0, t3
	lsb_not_1:
	slli t3, t3, 1
	srli t4, t4, 1
	bne  t4, zero, calc_mul_loop
	beq  zero, zero, calc_end
	calc_div:
	addi t0, zero, 3
	bne  t0, a1, calc_end
	addi a0, zero, 0xFFFFFFFF 
	add  a4, a2, zero
	add  t4, zero, a3
	add  t6, zero, a3
	beq  a3, zero, calc_end		#operand2가 0인지 체크
	xori a0, a0, 0xFFFFFFFF
	bge  a3, zero, not_neg_check1	#입력된 operand2가 음수인지 체크 
	xori t4, t4, 0xFFFFFFFF
	addi t4, t4, 1
	xori t6, t6, 0xFFFFFFFF
	addi t6, t6, 1
	not_neg_check1:
	bge  a4, zero, not_neg_check2	#입력된 operand1이 음수인지 체크 
	xori a4, a4, 0xFFFFFFFF
	addi a4, a4, 1
	not_neg_check2:
	slli t4, t4, 32
	calc_div_loop:
	slli a0, a0, 1
	add  t3, zero, a4
	xori t5, t4, 0xFFFFFFFF
	addi t5, t5, 1
	add  t5, t3, t5
	blt  t5, zero, msb_not_zero
	addi a0, a0, 1
	add  a4, t5, zero
	msb_not_zero:
	srli t4, t4, 1
	bge  t4, t6, calc_div_loop
	bge a2, zero, not_neg_op1
	xori a0, a0, 0xFFFFFFFF
	addi a0, a0, 1
	xori a4, a4, 0xFFFFFFFF
	addi a4, a4, 1
	not_neg_op1:
	bge a3, zero, calc_end
	xori a0, a0, 0xFFFFFFFF
	addi a0, a0, 1
	calc_end:
	jalr x0, 0(x1)


.include "common.asm"
