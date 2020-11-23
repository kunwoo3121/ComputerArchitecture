# RISC-V Processor의 Instruction

* 컴퓨터에게 일을 시키기
```
High-Level language program -> Assembly language program -> Binary machine language program
```

# Instruction
```
하드웨어와 소프트웨어의 중간 인터페이스, 프로세서의 Operation을 기술해놓은 Command

OPCODE | Operands 로 구성되어 있음

ex) add (opcode) $2, $4, $2 (operands) : 덧셈 Instruction
```

* CISC vs RISC
```
1) CISC : 오래된 스타일의 ISA, 복잡하다, Instruction 별로 길이가 다를 수 있다, 하나의 명령어가 다양한 기능을 한다.

 -장점 : 컴파일러가 RISC보다 단순하다, 명령어의 메모리 사용량이 감소한다.( 하나의 명령어가 여러 개의 행동을 할 수 있기 때문이다. )
 -단점 : CPU 디자인이 어렵다

2) RISC : CISC보다 새로운 컨셉, 단순하고 표준화된 명령어들, ARM/MIPS/RISC-V 등이 있다, 작은 instruction set, 한 개의 명령어는 한 개의 행동만 한다.
 
  -장점 : CPU 디자인이 쉬움, 작은 instruction set => clock speed를 CISC보다 높일 수 있다.
  -단점 : 메모리 사용량의 증가, 어셈블리어가 길어지게 된다.( 한가지 명령어가 한가지 행동만 할 수 있기 때문이다. ) 
```

* Instruction의 종류
```
1) Arithmetic Instruction : 산술연산을 실행하는 명령어

ex) add, sub, mul, div, rem, addi 등

2) Data Transfer Instruction : Memory에서 레지스터로 데이터를 가져오거나 레지스터에서 Memory로 데이터를 보내는 명령어
                               Load와 Store 명령어가 있다.
                               레지스터는 한정되어있기 때문에 대부분의 데이터는 Memory에 저장되어 있다.
                               필요할 때마다 메모리에서 레지스터로 데이터를 옮기거나 레지스터에서 메모리로 데이터를 옮겨야한다.

ex) ld, sd

3) Logical and Shift Instructions : 비트 단위의 연산을 하는 명령어
                                    AND 명령어는 원하는 범위의 bit를 보존하고 나머지를 0으로 만들 때 쓸 수 있다.
                                    OR 명령어는 원하는 범위의 bit를 1로 만들고 나머지는 원래대로 둘 때 쓸 수 있다.
                                    XOR 명령어는 bit를 뒤바꿀 때 쓸 수 있다.

ex) sll, srl, sra, and, or, xor, xori 등

4) Branch Instruction : 결정을 하기 위한 명령어, C언어의 if와 같은 기능을 한다.

ex) beq, bne 등

5) Unconditional Branch Instruction : 조건을 따지지 않고 특정 위치로 이동한다.

ex) jal, jalr 
```

* Operand의 종류
```
1) Register Operands : Arithmetic instruction의 operands는 레지스터에서 와야한다. 레지스터는 프로세서 내에 존재하고 자료를 빠르게 활용할 수 있다.
                       Risc-V는 64bit의 레지스터가 32개 있다.
                       x0 ~ x31 레지스터가 있고 x0 레지스터는 항상 0의 값을 저장하고 있다.
                       x0는 레지스터 간에 데이터를 옮길 때 사용할 수 있다.

2) Memory Operands : 메모리 주소를 가리키는데 Operand를 사용한다.
                     메모리 주소 = Offset(base_address) = base_addres + offset
                     Memory는 주소로 index 되어있는 1차원 배열로 추상화시킬 수 있다.
                     대부분의 프로세서들은 8bit의 개별적인 메모리 공간에 접근한다.

3) Immediate Operands : 상수 값을 나타내는 Operand
```

# RISC-V의 Instruction format
```
프로그램은 바이너리로 인코딩된 많은 명령어로 이루어져있다.
모든 RISC-V 명령어는 32bit의 길이를 가진다.
총 6개의 format이 있다.

1) R-format  : 3개의 register operand를 받는 명령어
2) I-format  : immediate operand를 받는 명령어 또는 load 명령어
3) S-format  : store 명령어
4) SB-format : Conditional branch instruction
5) U-format  : immediate의 상위 20비트를 다루는 명령어
6) UJ-format : Unconditional branch instruction
```

* R-format
```
funct7 / rs2 / rs1 / funct3 / rd / opcode ( 7 / 5 / 5 / 3 / 5 / 7 bit )

opcode : 명령어의 동작 내용
rd : 목적지 register
rs1 : 첫번째 source register
rs2 : 두번째 source register
funct3, funct7 : 명령어의 상세 내용 
```

* I-format
```
immediate / rs1 / funct3 / rd / opcode ( 12 / 5 / 3 / 5 / 7 bit )
```

* S-format
```
imm[11:5] / rs2 / rs1 / funct3 / imm[4:0] / opcode ( 7 / 5 / 5 / 3 / 5 / 7 bit )

imm[11:5] : 12bit immediate의 상위 7bit
imm[4:0]  : 12bit immediate의 하위 5bit
```

* U-format
```
imm[31:12] / rd / opcode ( 20 / 5 / 7 bit )

imm[31:12] : immediate의 상위 20bit를 다룬다.
```

* SB-format
```
imm[12] / imm[10:5] / rs2 / rs1 / funct3 / imm[4:1] / imm[11] / opcode ( 1 / 6 / 5 / 5 / 3 / 5 / 1 / 7 bit ) 

immediate[0]는 항상 0이다. 왜냐하면 모든 instruction의 주소는 짝수이기 때문에 저장할 필요가 없기 때문이다.
이를 이용하여 더 큰 bit를 다룰 수 있는 것이다.
```

* UJ-format
```
imm[20] / imm[10:1] / imm[11] / imm[19:12] / rd / opcode ( 1 / 10 / 1 / 8 / 5 / 7 bit )
```

# Addressing

* PC-relative addressing
```
PC = PC + { immediate + 뒤에 0을 하나 붙임 }
모든 instruction의 주소는 짝수이기 때문에 마지막 자리는 0이여도 괜찮다.
```

* Branch Far away
```
branch instruction의 목적지는 이 명령어와 가까이 있다.
하지만 매우 멀어지게 될 경우 ( 13 bit로 충족시키지 못할 때 ) 어셈블러가 code를 다시 쓴다.
```

# Procedure Calls
```
caller은 procedure을 호출, procedure은 callee
caller은 callee에게 data를 준다. ( argument )
callee는 caller에게 data를 준다. ( result )
```

* Procedure execution
```
1) Argument를 Procedure가 접근할 수 있는 곳에 둔다.
2) Procedure에게 Control을 준다.
3) 명령어 시행
4) 결과를 caller가 접근할 수 있는 곳에 둔다.
5) Pointer을 기존 위치로 옮김 ( return )

x10 ~ x17 : 패러미터나 결과값을 받는 데 사용되는 레지스터
x1 : return 시 돌아오는 주소를 저장하는 레지스터

procedure을 call할 때는 jal 명령어, caller로 돌아갈 때는 jalr 명령어를 사용한다.
```

* Using Stack
```
레지스터는 매우 빨라서 최대한 활용하여야 한다.

스택을 활용하여 레지스터의 값을 메모리에 저장하고 procedure가 끝이나면 다시 불러들인다.
-> 레지스터의 값을 유지하여 procedure가 call 되었을 때 레지스터를 활용할 수 있게 한다.
```
