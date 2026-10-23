# Validation plan

**Do not mark tests passed until you run them and save real output.** Expected outcomes are acceptance criteria, not pre-generated results.

## Test 1 — baseline isolation
Before peering/routes, on App-A:
```bash
ping -c 4 10.20.1.10
```
Expected: no replies.

## Test 2 — forward private connectivity
After peering is Active and routes/security rules are correct, on App-A:
```bash
ping -c 4 10.20.1.10
```
Expected: four replies and 0% packet loss (a first packet can be lost during host readiness; repeat if needed).

## Test 3 — reverse private connectivity
On App-B:
```bash
ping -c 4 10.10.2.10
```
Expected: four replies and 0% packet loss.

## Test 4 — private SSH via bastion
On your laptop:
```bash
ssh ewb-app-b
```
Expected: a shell on App-B through SSH ProxyJump. The `.pem` remains on your laptop.

## Test 5 — isolation
In EC2 console, verify App-A and App-B have no public IPv4 address.

## Test 6 — controlled failure and recovery
1. Temporarily remove only App-B's inbound ICMP Echo Request rule sourced from `10.10.2.10/32`.
2. Repeat Test 2. Expected: replies stop.
3. Restore the exact rule.
4. Repeat Test 2. Expected: replies resume.
5. Keep the SSH rule in place throughout.

## Troubleshooting order
1. Confirm instance state and actual private IPs.
2. Confirm peering status is Active.
3. Confirm correct subnet-to-route-table associations.
4. Confirm forward and return routes point to the actual `pcx-...`.
5. Confirm the destination security group permits the protocol from the source host.
6. Confirm network ACLs; this lab assumes defaults.
7. For SSH, confirm key, `ec2-user`, `ProxyJump`, and bastion public IP.
