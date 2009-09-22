#!/bin/sh
xpath transList.xhtml '//td/text()' 2>/dev/null | grep CZK | tail -n 1 | cut -d 'C' -f 1 > sum.txt
