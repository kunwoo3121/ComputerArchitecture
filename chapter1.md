* 컴퓨터의 발전
```
Moore's law = ic에 집적되는 트랜지스터의 수는 1965년 이후, 2년마다 2배 증가한다.
```

* 컴퓨터의 종류
```
1) Personal Computer : 일반적인 목적으로 사용, 소프트웨어가 다양함
2) Server Computer : 네트워크의 기반
3) Super Computer : 굉장히 많은 연산을 짧은 시간에 해낼 수 있음
4) Embedded Computer : 시스템의 구성요소로 숨겨져 있음
```
* 컴퓨터의 기본 기능
```
1) 데이터 주고 받기
2) 데이터 처리
3) 데이터 저장
```

* 폰 노이만의 컴퓨터 5가지 구성 요소
```
1) Datapath
2) Control Unit
3) Memory
4) Input
5) Output
```

* Technology Scaling ( 공정 기술 )
```
트랜지스터의 사이즈가 계속 줄어듬, 트랜지스터의 소모 전력도 작아짐 => 프로세서에 더 많은 트랜지스터를 넣을 수 있게 됨
프로세서의 clock frequency를 높일 수 있다.
```

* Performance의 측정
```
처리속도 등으로 performance를 측정할 수 있어야 한다.
1) Execution time : 일을 하는데 걸린 시간
2) Throughput : 단위 시간당 처리량

빠른 프로세서 사용 시 -> execution time, throughput 모두 개선
프로세서 수의 증가 시 -> throughput 개선
```

* 상대적인 Performance
```
Performance = 1 / Execution Time

X가 Y보다 n배 빠르다고 할 때 
-> Performance(X) / Performance(Y) = Execution Time(Y) / Execution Time(X) = n
```

* Execution Time의 측정
```
1) Elapsed time : 전체 execution time, 시스템 performance 측정에 사용된다.
2) CPU time : I/O에 사용되는 시간을 포함시키지 않는다, CPU performance 측정에 사용된다.
```

* CPU Time
```
CPU Time = CPU clock cycles * clock cycle time = CPU clock cycles / clock frequency

CPU clock cycles = 프로그램을 실행하는 동안 토글의 수
clock cycle time = clock 사이의 시간
clock frequency = 초당 발생하는 clock의 수
```

* CPI
```
CPI( Clock cycle per Instruction ) = 하나의 Instruction을 실행하기 위해 평균 몇 번의 clock cycle 이 있었는가를 나타낸다.

CPI = clock cycles / instruction count 

=> CPU Time = Instruction count * CPI / clock rate
```

* Power
```
Power = capacity load * voltage^2 * frequency

frequency를 높이면 소모되는 파워가 높아지고 이것은 온도를 높이는 결과를 부른다. => frequency를 계속해서 높일 수가 없다.

voltage를 낮출 경우 frequency를 높일 수 있지만 프로세서의 신뢰성이 떨어지게 된다.

따라서 하나의 processor의 frequency를 높이는 것보다 코어의 숫자를 늘리는 방향으로 개발 전략이 바뀌게 된다.
```

* Amdahl's law
```
프로그램의 모든 부분을 병렬처리할 수 없기 때문에 Parallel Computing의 성능 개선은 한계가 있다.

Time(improved) = Time(병렬처리가 가능한 부분) / 코어 수 + Time(병렬처리가 불가능한 부분)
```
