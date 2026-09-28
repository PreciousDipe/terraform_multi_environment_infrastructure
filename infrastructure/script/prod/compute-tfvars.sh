#!/usr/bin/env bash

set -euo pipefail

cat > terraform.tfvars <<'EOF'
# ── Compute Layer Configuration ───────────────────────────────────────────────
region               = "us-east-1"
environment          = "prod"

instance_type        = "t3.micro"
desired_capacity     = 2
max_size             = 4
min_size             = 1
ami_id               = "ami-0c7217cdde317cfec"
EOF

echo "Generated terraform.tfvars for compute:"
cat terraform.tfvars
