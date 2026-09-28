#!/usr/bin/env bash

set -euo pipefail

cat > terraform.tfvars <<'EOF'
# ── Database Layer Configuration ──────────────────────────────────────────────
region                 = "us-east-1"
environment            = "prod"

db_engine_version      = "15.4"
db_instance_class      = "db.t3.medium"
db_allocated_storage   = 100
db_multi_az            = true
db_deletion_protection = true
db_skip_final_snapshot = false
db_name                = "platformdb"
db_username            = "platformuser"
EOF

echo "Generated terraform.tfvars for database:"
cat terraform.tfvars
