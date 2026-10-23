# Project evidence report — fill in after your own AWS run

## Cover
- Student name:
- Batch:
- Project: CloudLink — AWS VPC Peering Lab
- Region:
- Completion date:

## Resource inventory
| Resource | Actual AWS ID | Name tag | CIDR / private IP |
|---|---|---|---|
| VPC A | | `ewb-vpc-a` | `10.10.0.0/16` |
| VPC B | | `ewb-vpc-b` | `10.20.0.0/16` |
| Peering | | `ewb-a-b-peer` | Active? |
| Bastion | | `ewb-bastion` | `10.10.1.10`, public IP: |
| App-A | | `ewb-app-a` | `10.10.2.10`, no public IP |
| App-B | | `ewb-app-b` | `10.20.1.10`, no public IP |

## Architecture and route tables
Insert your architecture diagram and screenshots showing each route table, its subnet association, and all relevant routes.

## Security groups
Insert screenshots of the actual inbound rules for all three groups. Confirm no SSH or ICMP rule uses `0.0.0.0/0`.

## Test evidence
For each test, paste a screenshot or terminal capture with host, command, timestamp, and actual result:
- [ ] Baseline failure before peering/routes
- [ ] App-A → App-B private ping success
- [ ] App-B → App-A private ping success
- [ ] SSH to App-B through bastion using ProxyJump
- [ ] App-A and App-B have no public IPv4
- [ ] ICMP rule removal causes failure
- [ ] Restoring ICMP rule restores connectivity

## Explanation
Describe the forward route and return route. Explain why the public route table requires a peering route for bastion-to-App-B SSH.

## Cleanup
- [ ] Saved evidence before deletion
- [ ] Terminated all three EC2 instances
- [ ] Deleted leftover EBS volumes/snapshots if created
- [ ] Released any Elastic IP allocated for this lab
- [ ] Deleted peering and peer routes
- [ ] Deleted security groups, route tables, subnets, internet gateway, and both VPCs
- [ ] Checked Billing for remaining resources/charges

## Lessons learned
Write 3–5 points based on what you actually built and debugged. Do not claim tests passed unless your evidence proves it.
