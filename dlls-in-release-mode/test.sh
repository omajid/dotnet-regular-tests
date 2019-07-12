#!/bin/bash

# Check that all .NET Core is compiled in release mode
#
# - At the moment, only NGEN dlls are compiled differently for release
#   vs debug mode

set -euo pipefail
IFS=$'\n\t'

script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

dotnet_dir=$(dirname "$(readlink -f "$(which dotnet)")")

find "${dotnet_dir}" -iname '*.dll' -type f -print0 | xargs -0 "${script_directory}/check-ngen-dlls"

if find "${dotnet_dir}" -iname '*.dll' -type f -print0 | xargs -0 "${script_directory}/check-ngen-dlls" | grep 'wBuild: 0x0'; then
    echo "Found some dlls built in debug mode"
    exit 1
fi

echo "PASS"
exit 0
