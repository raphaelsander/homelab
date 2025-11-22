# My Homelab

## Bare Metal

![Hypervisor](imgs/hypervisor.png)

## Subnets

| Nome              | Network        | Mask            | Gateway     | Hosts IPs | Broadcast   |
|:----------------- |:-------------- |:--------------- |:----------- |:--------- |:----------- |
| administrator (1) | 172.16.0.0/28  | 255.255.255.240 | 172.16.0.1  | 2 – 9     | 172.16.0.15 |
| personal (2)      | 172.16.0.16/29 | 255.255.255.248 | 172.16.0.17 | 18 – 21   | 172.16.0.23 |
| ragnarok-wiki (3) | 172.16.0.24/30 | 255.255.255.252 | 172.16.0.25 | 26        | 172.16.0.27 |
| media (4)         | 172.16.0.28/30 | 255.255.255.252 | 172.16.0.29 | 30        | 172.16.0.31 |

![Subnet Diagram](imgs/subnet_diagram.jpg)
