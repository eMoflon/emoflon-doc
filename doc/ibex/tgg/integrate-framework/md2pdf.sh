#!/bin/bash

set -e

if [ -e 'all.md' ]; then rm all.md; fi

# Concat all mds to one file
for i in *.md;
    do echo "<div id=\"$i\"></div>" | cat - $i >>all.md
done

# Compile the file
pandoc -f markdown --lua-filter=hashids.lua -o integrate-framework.pdf all.md
rm all.md
