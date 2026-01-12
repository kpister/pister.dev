#!/bin/bash

# Deploy pister.dev to S3

set -e

export AWS_PROFILE=kaiser

echo "Deploying pister.dev..."

# Exclusions for files that shouldn't be deployed
EXCLUDES="--exclude '.git/*' \
          --exclude 'venv/*' \
          --exclude '.DS_Store' \
          --exclude '*.sh' \
          --exclude 'README.md' \
          --exclude '.gitignore' \
          --exclude '*.pyc' \
          --exclude '__pycache__/*'"

# Sync to both buckets with ACL set during upload (faster than post-upload ACL loop)
echo "Syncing to pister.dev..."
eval aws s3 sync . s3://pister.dev --acl public-read --delete $EXCLUDES

echo "Syncing to www.pister.dev..."
eval aws s3 sync . s3://www.pister.dev --acl public-read --delete $EXCLUDES

echo "Deploy complete!"
echo ""
echo "Deployed:"
echo "  - index.html"
echo "  - blog/"
echo "  - files/"
echo "  - 538/"
echo "  - 638/"
