#!/usr/bin/bash

set -euo pipefail
set -x

declare -A archmap
archmap=(
    ["aarch64"]="arm64"
    ["amd64"]="x64"
    ["armv8b"]="x64"
    ["armv8l"]="x64"
    ["i686"]="x86"
    ["i386"]="x86"
    ["x86_64"]="x64"
)

arch=${archmap["$(uname -m)"]}

dotnet new console --no-restore
dotnet publish -r linux-${arch} /p:PublishReadyToRun=true