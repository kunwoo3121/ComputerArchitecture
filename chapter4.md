# Logic Design Basics
하드웨어는 Logic gates라고 불리는 것들로 이루어져있다.
logic gates는 트랜지스터로 만들어진다.

* Digital Logic Types
```
1) Combinational Logic : 입력데이터에 대해 작동, 출력은 오로지 현재의 입력에만 영향을 받는다.
2) Sequential Logic : 출력은 현재 입력에만 영향을 받지 않고 과거의 입력에도 영향을 받는다.
                      따라서 값을 저장할 수 있어야 한다.
```

* Combinational Logic
```
1) Multiplexer : 입력에 따라 출력 값을 선택한다.

2) ADDER : 덧셈 연산을 수행한다.

3) ALU : Multiplexer을 통해 어떤 연산을 수행할 지 선택하고 그 연산을 수행하는 장치
```

* Sequential Logic
```
1) Latch : input이 바뀌면 output이 바로 바뀐다.
           비동기 회로에서 이용된다.
           
2) Flip-flop : 동기 회로에서 이용된다. ( 하나의 신호에 동작이 맞춰짐 )
               n bit 레지스터는 n 개의 Flip-flop으로 이루어져있다.
               clock signal에 의해 값을 언제 저장할지 결정한다.
               clock의 rising edge에서만 값이 업데이트된다.
```

* 주의할 점
```
Combinational logic의 delay ( input이 들어오고 output이 나오는 시간 )가 clock period보다 짧아야 값을 문제없이 업데이트할 수 있다.
따라서 Clock period를 줄이려면 delay도 같이 줄여야 문제가 발생하지 않는다.
```
