# 컴퓨터의 연산

* Binary Addition
```
연산 결과 sign bit (최상위 비트)의 값이 바뀌어 버리는 경우 Overflow이다.
다른 부호의 수를 더할 경우 Overflow는 발생하지 않는다.
```

* Binary Subtraction
```
같은 부호의 수를 연산할 경우 Overflow는 발생하지 않는다.
```

* Multiplication
```
사용 레지스터 : Multiplicand 1개, Product 1개, Multiplier 1개

Multiplier의 LSB ( 가장 마지막 bit )를 체크하여 1이면 Product에 Multiplicand의 값을 저장
그 후 Multiplier을 오른쪽으로 1bit shift, Multiplicand를 왼쪽으로 1bit shift한다.
위의 과정을 Multiplier가 0이 될 때까지 반복한다.

ex) 0010과 0011을 곱한다고 할 때

1) Multiplicand : 0000 0010, Product : 0000 0000, Multiplier : 0011

   Multiplier의 LSB가 1이므로 
   
   => Multiplicand : 0000 0010, Product : 0000 0010, Multiplier : 0011

2) Multiplicand : 0000 0100, Product : 0000 0010, Multiplier : 0001
   
   Multiplier의 LSB가 1이므로 
   
   => Multiplicand : 0000 0100, Product : 0000 0110, Multiplier : 0000

3) Multiplier가 0이 되었으므로 종료
  
   결과값은 Product에 저장된 0000 0110이 된다.
```

* Optimized Multiplier 
```
위의 과정보다 적은 수의 레지스터를 이용한다.
Multiplicand와 Product 레지스터만 이용한다.

Product의 하위 64비트에 Multiplier을 저장해둔다.
이 Multiplier의 LSB가 1이면 Product의 상위 64비트에 Multiplicand를 더한다.
그리고 Product를 1bit 오른쪽으로 shift한다.

Multiplier가 모두 shift되어 없어질때까지 위의 과정을 반복한다.

ex) 0010 * 0011

1) Product : 0000 0011, Multiplicand : 0010

Multiplier의 LSB가 1이므로 연산 시행

=> Product : 0010 0011, Multiplicand : 0010

2) Product : 0001 0001, Multiplicand : 0010

Multiplier의 LSB가 1이므로 연산 시행

=> Product : 0011 0001, Multiplicand : 0010

3) Product : 0001 1000, Multiplicand : 0010

4) Product : 0000 1100, Multiplicand : 0010

5) Product : 0000 0110, Multiplicand : 0010 

Multiplier가 모두 오른쪽으로 shift되어 없어지고 결과값은 Product에 저장되어있는 0000 0110이 된다.
```
