#!/usr/bin/env bash

set -euo pipefail

cat > terraform.tfvars <<'EOF'
# ── Database Layer Configuration ──────────────────────────────────────────────
region      = "us-east-1"
environment = "dev"

db_engine_version      = "15.4"
db_instance_class      = "db.t3.micro"
db_allocated_storage   = 20
db_multi_az            = false
db_deletion_protection = false
db_skip_final_snapshot = true
db_name                = "platformdb-dev"
db_username            = "platform-dev-user"
EOF

echo "Generated terraform.tfvars for database:"
cat terraform.tfvars
