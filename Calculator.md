# RISC-V 명령어를 이용한 사칙연산 계산기 만들기

RISC-V 시뮬레이터를 이용해 RISC-V 명령어를 사용해본다.

* 조건
```
1) 사칙연산을 수행할 때 add 명령어 이외의 명령어는 사용하지 않는다. ( ex) sub, mul, div )
2) 콘솔을 통해 입력을 받고 콘솔에 결과를 출력한다.
```

## 콘솔 입력받기
![1](https://user-images.githubusercontent.com/28796089/100012844-46177500-2e17-11eb-92ab-42bd219f1246.JPG)
```
System Call을 이용해 String을 Console을 통해 입력받는다.

입력받은 String은 메모리에 저장이 되어있으므로 이것을 레지스터로 옮겨서 사용해야한다.

byte단위로 메모리에서 읽어서 그것이 숫자인지 연산자인지 판단하고 값을 저장해둔다.

q를 입력받으면 콘솔에서 입력을 받는 것을 그만두고 프로그램을 종료한다.
```
![2](https://user-images.githubusercontent.com/28796089/100012956-7232f600-2e17-11eb-9144-27dfefb3735f.JPG)
```
숫자인지 연산자인지 판단하는 과정 중 하나이다.

- 의 경우 이것이 연산자인지 부호를 나타내는 것인지 판단해야하므로 그 과정도 포함시킨다.
```
![3](https://user-images.githubusercontent.com/28796089/100013126-adcdc000-2e17-11eb-9a84-52b12f5caa49.JPG)
![4](https://user-images.githubusercontent.com/28796089/100013185-c342ea00-2e17-11eb-8284-0d67cd046eb5.JPG)
```
위와 같은 과정을 통해 콘솔을 통해 String을 입력받고 값을 레지스터에 저장한다.
```

