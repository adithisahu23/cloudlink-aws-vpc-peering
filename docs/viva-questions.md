# Viva / interview questions

## 1. What is VPC Peering?
A private network connection between two VPCs that allows routing between their private IP ranges when routes and security rules permit it.

## 2. Why must the VPC CIDRs not overlap?
Overlapping IPv4 address ranges make routing ambiguous; AWS does not allow peering between VPCs with overlapping CIDRs.

## 3. Why do both VPCs need routes?
Traffic needs a forward path and a return path. A route in only one VPC is insufficient for bidirectional communication.

## 4. Why does the public route table need a peering route?
The bastion is in the public subnet. When it opens an SSH connection to App-B, its subnet's route table must route `10.20.0.0/16` to the peering connection.

## 5. Why is App-B's SSH source the bastion's private IP?
ProxyJump makes the bastion establish a separate SSH connection to App-B. App-B sees the bastion's private IP as the source on that network path.

## 6. Does Active peering guarantee connectivity?
No. The relevant subnet route tables, security groups, network ACLs, host state, and destination IP must also be correct.

## 7. Does peering give VPC B internet access through VPC A?
No. VPC peering is not transitive and does not make the peer's internet gateway a shared internet gateway.

## 8. What does `/32` mean in a security-group source?
It denotes one IPv4 address, allowing a narrowly scoped host rule.

## 9. Why use a bastion?
It provides a controlled administrative entry point while the application instances remain without public IPv4 addresses. Production environments may prefer AWS Systems Manager Session Manager or other managed access patterns.

## 10. What is the controlled failure test proving?
It demonstrates that connectivity depends on the destination security-group rule, not merely on the peering state and routes.
