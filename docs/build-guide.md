# Build guide (console workflow)

This sequence follows the uploaded EWB workbook. Console labels may change slightly.

## 0. Before creating resources
- Choose one Region (for example `ap-south-1`) and use one account.
- Check AWS pricing, credits, and permissions.
- Create a local folder for screenshots and notes.
- Never upload the private key into this repository.

## 1. VPC A
1. Create VPC `ewb-vpc-a`, IPv4 CIDR `10.10.0.0/16`.
2. Create `ewb-a-public` (`10.10.1.0/24`) and `ewb-a-private` (`10.10.2.0/24`).
3. Create and attach internet gateway `ewb-igw-a`.
4. Create `ewb-rt-a-public`, associate it with the public subnet, and add `0.0.0.0/0 → ewb-igw-a`.
5. Create `ewb-rt-a-private`, associate it with the private subnet, and keep only the local route for now.

## 2. VPC B
1. Create `ewb-vpc-b`, IPv4 CIDR `10.20.0.0/16`.
2. Create `ewb-b-private` (`10.20.1.0/24`).
3. Create `ewb-rt-b-private`, associate it with that subnet, and keep only the local route for now.
4. Do not create an internet gateway or enable public IPv4 auto-assignment in VPC B.

## 3. Security groups
Create three groups, each in the correct VPC. Keep default outbound allow-all for this beginner lab and use default network ACLs.

| Group | Inbound rule | Source |
|---|---|---|
| `ewb-sg-bastion` | SSH TCP/22 | Your current public IPv4 `/32` |
| `ewb-sg-app-a` | SSH TCP/22 | `10.10.1.10/32` |
| `ewb-sg-app-a` | ICMP IPv4 Echo Request | `10.20.1.10/32` |
| `ewb-sg-app-b` | SSH TCP/22 | `10.10.1.10/32` |
| `ewb-sg-app-b` | ICMP IPv4 Echo Request | `10.10.2.10/32` |

Do not use `0.0.0.0/0` for SSH or ICMP. If the public IP of the laptop changes, update the bastion rule.

## 4. EC2
1. Create a key pair named `ewb-lab` and keep the `.pem` file locally.
2. Launch Amazon Linux 2023 instances, using a small approved type and checking current prices.
3. Launch `ewb-bastion` in `ewb-a-public`, private IP `10.10.1.10`, with a public IPv4.
4. Launch `ewb-app-a` in `ewb-a-private`, private IP `10.10.2.10`, without a public IPv4.
5. Launch `ewb-app-b` in `ewb-b-private`, private IP `10.20.1.10`, without a public IPv4.
6. Wait for all instances to pass status checks. Record real instance IDs and the bastion public IPv4.

## 5. Confirm the baseline
Configure local SSH using `ssh/config.example` (copy it into your local `~/.ssh/config` and replace `BASTION_PUBLIC_IP`). Set key permissions to `chmod 400 ~/.ssh/ewb-lab.pem`.
- Test `ssh ewb-bastion`.
- Test `ssh ewb-app-a`.
- From App-A run `ping -c 4 10.20.1.10`. Before peering and routes, this should receive no replies.

## 6. Create peering
1. Create peering connection `ewb-a-b-peer`, requester VPC A, accepter VPC B, same account and Region.
2. Accept the request, wait for **Active**, and record the actual `pcx-...` ID.

## 7. Add routes
See `security-and-routing.md`. Add the route to VPC B from both VPC A route tables and add the return route in VPC B. Keep local and internet routes.

## 8. Validate and capture evidence
Run both directions of ICMP, SSH to App-B using `ssh ewb-app-b`, and the controlled failure/recovery described in `test-plan.md`. Save actual output and screenshots.

## 9. Clean up
After saving evidence, follow `scripts/cleanup-checklist.sh` and the official console workflow. Verify no project resources remain and review Billing.
