#!/bin/bash -e

for prefix in base ou user group; do # prefix order is important
    for f in $prefix*.ldif; do
        ldapadd -f $f -D {{ root_dn }} -w {{ root_password }}
    done
done
