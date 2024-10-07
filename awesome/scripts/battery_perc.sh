#!/bin/sh
sed -E 's/.*,([0-9]+)%,.*/\1/' <<< $(acpi -b | sed 's/ //g')
