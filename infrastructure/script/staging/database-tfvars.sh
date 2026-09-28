#!/usr/bin/env bash

set -euo pipefail

cat > terraform.tfvars <<'EOF'
# ── Database Layer Configuration ──────────────────────────────────────────────
region                 = "us-east-1"
environment            = "staging"

db_engine_version      = "15.4"
db_instance_class      = "db.t3.small"
db_allocated_storage   = 50
db_multi_az            = false
db_deletion_protection = false
db_skip_final_snapshot = true
db_name              = "platformdb-staging"
db_username          = "platform-staging-user"
EOF

echo "Generated terraform.tfvars for database:"
cat terraform.tfvars
