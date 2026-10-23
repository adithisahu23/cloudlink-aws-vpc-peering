# Architecture and design rationale

## Objective
Connect workloads in two separate VPCs using their private IPv4 addresses while keeping both application EC2 instances private.

## Components
- **VPC A (`10.10.0.0/16`)**: public subnet for the bastion and private subnet for App-A.
- **VPC B (`10.20.0.0/16`)**: private subnet for App-B; no internet gateway.
- **Internet Gateway**: attached only to VPC A.
- **VPC Peering**: one-to-one private network path between VPC A and VPC B.
- **Route tables**: explicit forward and return paths.
- **Security groups**: restrict SSH and ICMP to named lab hosts.
- **Bastion**: the only instance with a public IPv4 address; SSH keys stay on the user's laptop and ProxyJump forwards the connection.

## Traffic flows
1. Laptop → bastion public IPv4: TCP/22, allowed only from the user's current public IPv4 `/32`.
2. Bastion → App-A: TCP/22 over VPC A's local route.
3. Bastion → App-B: TCP/22 via VPC A public route table's `10.20.0.0/16 → pcx-...` route, then VPC B's return route.
4. App-A ↔ App-B: private IPv4 traffic through VPC Peering. Both directions need routes and destination security rules.

## Why non-overlapping CIDRs?
VPC peering cannot be established when the VPC IPv4 CIDR ranges overlap. `10.10.0.0/16` and `10.20.0.0/16` are distinct.

## Limitations
VPC peering is non-transitive. An A–B connection and an A–C connection do not automatically permit B–C traffic. Peering does not provide transitive routing or internet access through the peer VPC's internet gateway.
