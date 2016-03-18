#!/bin/bash -e

for prefix in group user ou base; do # prefix order is important
    for dn in `grep '^dn: ' $prefix*.ldif | awk '{print $2}'`; do
        echo delete $dn
        ldapdelete $dn -D {{ root_dn }} -w {{ root_password }}
    done
done
