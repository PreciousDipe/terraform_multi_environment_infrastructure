#!/usr/bin/env bash

set -euo pipefail

cat > terraform.tfvars <<'EOF'
# ── Network Layout Configuration ──────────────────────────────────────────────
region      = "us-east-1"
environment = "prod"

vpc_cidr             = "10.0.0.0/16"
az_count             = 2
public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
enable_nat_gateway   = true
EOF

echo "Generated terraform.tfvars for networking:"
cat terraform.tfvars
