# 컴퓨터의 사칙 연산

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

ex) 0010 * 0011

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

* Division
```
세 개의 레지스터를 사용한다 : Divisor 1개, Remainder 1개, Quotient 1개

Divisor에 나누는 수를 비트 수만큼 왼쪽으로 shift하여 저장해둔다.
Remainder에는 나누어지는 수를 저장한다.

Remainder - Divisor의 결과가 양수이면 그 값을 Remainder에 저장해두고 Quotient의 값을 1증가시킨다.

Divisor의 값이 원래 나누는 수와 같아질 때까지 반복하며
반복할 때마다 Divisor을 오른쪽으로 1bit shift, Quotient를 왼쪽으로 1bit shift한다.

ex) 0111 / 0010

1) Divisor : 0010 0000, Remainder : 0000 0111, Quotient : 0000

2) Divisor : 0001 0000, Remainder : 0000 0111, Quotient : 0000

3) Divisor : 0000 1000, Remainder : 0000 0111, Quotient : 0000

4) Divisor : 0000 0100, Remainder : 0000 0111, Quotient : 0000

   Remainder - Divisor의 값이 양수이므로 연산 시행
   
   => Divisor : 0000 0100, Remainder : 0000 0011, Quotient : 0001

5) Divisor : 0000 0010, Remainder : 0000 0011, Quotient : 0010

   Remainder - Divisor의 값이 양수이므로 연산 시행
   
   => Divisor : 0000 0010, Remainder : 0000 0001, Quotient : 0011
   
6) Divisor의 값이 원래 값인 0010이 되었으므로 종료
   몫은 Quotient 레지스터에 저장되어있는 0011, 나머지는 Remainder에 저장되어있는 0001이 된다.
```

* Optimized Divider
```
위의 나눗셈 과정보다 레지스터를 1개 덜 사용한다.

Remainder 레지스터의 하위 64비트에 Quotient를 저장한다.

Divisor 대신에 Remainder을 왼쪽으로 1bit shift한다.

Remainder의 상위 64비트와 Divisor을 뺄셈 연산하여 양수가 나오면 Remainder의 값을 1증가 시킨다.

위의 과정을 수의 bit수만큼 반복하면 Remainder의 상위 64비트가 나머지, 하위 64비트가 몫이다.

Optimized Multiplier와 굉장히 유사한 구조를 하고 있어서 같은 하드웨어를 활용할 수 있다.

ex) 0111 / 0010

1) Remainder : 0000 0111, Divisor : 0010

2) Remainder : 0000 1110, Divisor : 0010

3) Remainder : 0001 1100, Divisor : 0010

4) Remainder : 0011 1000, Divisor : 0010

   Remainder 상위 64비트 - Divisor 가 양수이므로 연산 시행

   => Remainder : 0001 1001, Divisor : 0010

5) Remainder : 0011 0010, Divisor : 0010
 
   Remainder 상위 64비트 - Divisor 가 양수이므로 연산 시행

   => Remainder : 0001 0011, Divisor : 0010

6) 4 bit 만큼 shift 되었으므로 종료 
   몫은 하위 4비트인 0011, 나머지는 상위 4비트인 0001이다.
```

# Floating Point Number 
소수를 나타내는 방법, 아주 작은 수나 매우 큰 수를 표현하기 위해 사용한다.

* Binary number form
```
± 1.xxxxx....(2) * 2^y

x : fraction, y : exponent 

fraction을 저장하는 bit가 커질수록 숫자의 정확도가 증가하고
exponent을 저장하는 bit가 커질수록 표현할 수 있는 수의 범위가 증가한다.
```

* Single Precision : 32bit
```
32bit로 나타내는 경우

sign / exponent / fraction ( 1 / 8 / 23 bit )
```

* Double Precision : 64bit
```
64bit로 나타내는 경우

sign / exponent / fraction ( 1 / 11 / 52 bit)

훨씬 큰 bit를 fraction에 할당하여 정밀도가 크게 증가한다.
```

* IEEE 754 Floating-Point Format
```
1) 부호 비트가 0일때 양수, 1일때 음수를 나타낸다.

2) Significand : 1 + Fraction

3) Exponent : 실제 Exponent에 bias가 더해진 값이다.
              bias는 single precision에서는 127
              double precision에서는 1207이다.
              
              bias exponent를 사용하는 이유는 크기 비교의 방법을 단순화시키기 위해서이다.
```
