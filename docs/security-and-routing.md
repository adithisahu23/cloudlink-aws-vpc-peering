# Routing and security matrix

## Required route entries

Keep AWS-created local routes. Add only the missing routes.

| Route table | Destination | Target | Why |
|---|---|---|---|
| `ewb-rt-a-private` | `10.20.0.0/16` | actual peering ID `pcx-...` | App-A → VPC B |
| `ewb-rt-b-private` | `10.10.0.0/16` | actual peering ID `pcx-...` | Return route to VPC A |
| `ewb-rt-a-public` | `10.20.0.0/16` | actual peering ID `pcx-...` | Bastion → App-B for ProxyJump |
| `ewb-rt-a-public` | `0.0.0.0/0` | attached internet gateway | Bastion internet access |

The route table for VPC A's private subnet and VPC A's public subnet both need the VPC B route because App-A and the bastion originate traffic from different subnets. VPC B needs the route back to VPC A.

## Security-group rules

| Security group | Protocol / port | Source |
|---|---|---|
| `ewb-sg-bastion` | TCP 22 | your current public IPv4 `/32` |
| `ewb-sg-app-a` | TCP 22 | `10.10.1.10/32` |
| `ewb-sg-app-a` | ICMPv4 Echo Request | `10.20.1.10/32` |
| `ewb-sg-app-b` | TCP 22 | `10.10.1.10/32` |
| `ewb-sg-app-b` | ICMPv4 Echo Request | `10.10.2.10/32` |

For ICMP echo request, select ICMP IPv4 type 8/code 0 if the console requests a type and code. Security groups are stateful; return packets for permitted flows are automatically allowed. This lab assumes default allow-all network ACLs.

## Route selection
AWS selects the most specific matching route. For VPC B addresses, `10.20.0.0/16 → pcx-...` is more specific than the public subnet's `0.0.0.0/0 → IGW`, so traffic to VPC B uses peering, not the internet gateway.
