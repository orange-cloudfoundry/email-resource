#!/bin/bash -e

if [ -d ".git" ]; then
  if ${DEV}; then
    ts=$(date +"%Y%m%M%S%N")
    DRAFT_VERSION="dev-${ts}"
  else
    DRAFT_VERSION=`versioning bump_patch`-`git rev-parse HEAD`
  fi
else
  DRAFT_VERSION="v0.0.0-local"
fi
echo "next version should be: ${DRAFT_VERSION}"

GOOS=linux GOARCH=amd64 go build  -o bin/check -ldflags "-s -w" ./check/cmd
GOOS=linux GOARCH=amd64 go build -o bin/in -ldflags "-s -w" ./in/cmd
GOOS=linux GOARCH=amd64 go build -o bin/out -ldflags "-s -w -X main.VERSION=${DRAFT_VERSION}" ./out/cmd

