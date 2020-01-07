#!/bin/bash

carrillonScript="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
carrillonDeploy="$(dirname "$carrillonScript")"
carrillonRoot="$(dirname "$carrillonDeploy")"

# If we don't specify this LANG or any other compatible one
# we would get quite some test failures
# Some Linux are fine just with $LANG but some others (like Raspbian) do already
# export $LC_ALL so if we don't override it, VA will still pick 
# up the default encoding. So, just in case, we expor all variables. 
export LANG=en_US.iso88591; export LANGUAGE=en_US.iso88591; export LC_ALL=en_US.iso88591

vastRoot="$carrillonRoot/deploy/vast92"
export LD_LIBRARY_PATH="$vastRoot/bin:$LD_LIBRARY_PATH"
$vastRoot/bin/esnx -no_break -msd -mcd -i$carrillonScript/carrillon-unix-32.icx -ini:$carrillonScript/carrillon-unix-32.ini
