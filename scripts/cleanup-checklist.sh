#!/usr/bin/env bash
set -euo pipefail
cat <<'CHECKLIST'
SAFE CLEANUP CHECKLIST — this script does NOT delete AWS resources.

1. Save all screenshots, terminal outputs, IDs, and your report.
2. Terminate ewb-bastion, ewb-app-a, and ewb-app-b.
3. Check for leftover lab EBS volumes/snapshots; remove only those you created.
4. Release any Elastic IP allocated for this project.
5. Remove VPC peering routes, then delete ewb-a-b-peer.
6. Delete the lab security groups after attached network interfaces are gone.
7. Delete subnet associations as required, then custom route tables and subnets.
8. Detach and delete ewb-igw-a.
9. Delete ewb-vpc-a and ewb-vpc-b.
10. Delete the unused lab key pair if no longer needed; remove local key securely if appropriate.
11. Filter by Project=EWB-VPC-Peering in the chosen Region and verify no lab resources remain.
12. Check Billing; usage reporting can lag.

Never delete resources unrelated to this lab.
CHECKLIST
