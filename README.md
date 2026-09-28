# Организация сети: Yandex Cloud — VPC, NAT Instance и Private Subnet

## Задание

Необходимо создать инфраструктуру в Yandex Cloud с использованием Terraform:

1. Создать VPC.
2. Создать публичную подсеть `public` с сетью `192.168.10.0/24`.
3. Создать в публичной подсети NAT-инстанс с IP `192.168.10.254` и образом `fd80mrhj8fl2oe87o4e1`.
4. Создать в публичной подсети виртуальную машину с публичным IP и проверить доступ в Интернет.
5. Создать приватную подсеть `private` с сетью `192.168.20.0/24`.
6. Создать route table со статическим маршрутом `0.0.0.0/0` через NAT-инстанс `192.168.10.254`.
7. Создать виртуальную машину в приватной подсети без публичного IP.
8. Подключиться к Private VM через Public VM и проверить доступ в Интернет.

## VPC

Создана VPC:

- Network key: `develop`
- Network name: `network-hw-cloud`
- Zone: `ru-central1-a`

## Public subnet

Параметры:

- Name: `public`
- CIDR: `192.168.10.0/24`
- Zone: `ru-central1-a`

## Private subnet

Параметры:

- Name: `private`
- CIDR: `192.168.20.0/24`
- Zone: `ru-central1-a`
- Route table: `private`

## NAT Instance

NAT-инстанс размещён в публичной подсети.

Параметры:

- Name: `nat-instance-1`
- IP: `192.168.10.254`
- Image ID: `fd80mrhj8fl2oe87o4e1`
- Subnet: `public`

NAT-инстанс используется как шлюз для приватной подсети.

## Public VM

Public VM размещена в подсети `public`.

Параметры:

- Subnet: `public`
- CIDR: `192.168.10.0/24`
- Public IP: есть
- NAT: включён

## Route Table

Для приватной подсети создана таблица маршрутизации.

Статический маршрут:

```text
Destination: 0.0.0.0/0
Next hop:    192.168.10.254
```

Весь исходящий трафик Private VM направляется на NAT-инстанс.

## Private VM

Private VM размещена в подсети `private`.

Параметры:

- Subnet: `private`
- CIDR: `192.168.20.0/24`
- Internal IP: `192.168.20.x`
- Public IP: отсутствует
- NAT: отключён

Private VM доступна по SSH через Public VM и имеет доступ в Интернет через NAT Instance.

<img width="2214" height="1507" alt="изображение" src="https://github.com/user-attachments/assets/ca7c4946-d042-494f-84a7-517a10658013" />

