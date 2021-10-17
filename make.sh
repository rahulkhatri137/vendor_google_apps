#!/bin/bash

# Core variables, don't edit.
LOCALDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYSTEMDIR="$1"
AV="$2"
APPS="AndroidMigratePrebuilt AndroidPlatformServices CalculatorGooglePrebuilt CalendarGooglePrebuilt Drive GoogleContacts LatinIMEGooglePrebuilt Maps Phonesky PrebuiltBugle PrebuiltDeskClockGoogle PrebuiltGms PrebuiltGmsCore PrebuiltGmsCorePi Turbo Velvet YouTube"
PASS=false

# Check if it's an gapped-gsi
for app in $APPS; do
    apppath="$(realpath "$(find $SYSTEMDIR -name $app.apk)" 2> /dev/null)"
    [[ -z $apppath ]] && continue
    if [ -f $apppath ]; then
        echo " - Error! Seem to already have GApps on this GSI, abort."
        exit 1
    fi
done
PASS=true

# Check if the PASS variable is true
if [ $PASS == true ]; then
    echo " - Copying the GApps into system..."
    rsync -ra $LOCALDIR/$AV/system $SYSTEMDIR/..
    echo " - Done! It is an experimental function, not recommended to use."
fi