# qic_cic

**Objectives:** 

- QIC와 CIC의 모형 검증 능력 평가
- CIC가 longitudinal ordinal data를 분석하는 데 있어 다양한 모형을 비교하는 데 효과적인 비교 지수가 될 수 있는지 평가

**배경 설명**

- 시간에 따른 변화 추이를 분석하기 위한 모형으로는 linear mixed model이 전통적인 방법으로 선호되어왔으나, 데이터의 속성에 따라 mean structure와 correlation structure를 각각 올바르게 설정해주어야 함
- Ordinal data를 위한 marginal model에서는 AIC, BIC와 같은 기존 적합도 지수와 달리 quasi-likelihood 기반의 QIC를 사용할 필요가 있음 (Pan, 2001)
- 그러나 기존 binary, count 자료들과는 달리 ordinal 자료는 분포를 가정하는 데 어려움이 있어 일반적으로 패키지에서 QIC를 계산하는 내장함수를 제공하지 않음 → 새로운 내장함수를 R로 구현해야 함
- 따라서 대안으로 CIC 지수 계산식을 구현하고, 이에 기반하여 가장 적절한 local odds ratio structure를 선정하였음
- CIC는 아래와 같이 정의되는 QIC에서 trace 부분이 분산에 대한 정보를 포함하고 있다는 점에 착안하여 quasi-likelihood가 관여하는 부분을 제외한 지수임 (Hin & Wang, 2009)
- Ordinal data를 분석하는 데 사용하는 r 패키지 중 하나인 repolr 패키지에 내장된 QIC 함수를 가지고 와서 CIC를 구성함

**시뮬레이션**

- Possion 분포 하에서 1000개의 sample에 4개 시점, 시점에 따른 변수 X를 가정함. Correlation structure는 Compound Symmetry로 설정
- Compound Symmetry는 본질적으로 exchangeable과 구조가 같으므로, CIC와 QIC가 올바르게 기능한다면 exchangeable 구조를 선호할 것

**QIC formula (Hin & Wang, 2009)**

![Screen Shot 2022-03-23 at 4.44.20 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/71bd6a54-08d3-4af3-83e6-e7d5214e6a52/Screen_Shot_2022-03-23_at_4.44.20_PM.png)
