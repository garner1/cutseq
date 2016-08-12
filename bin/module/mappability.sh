#!/usr/bin/env bash

exp=$1

# need to parallelize wrt to patfile as well
parallel -k "scan_for_matches patfile < {} >> $PWD/hits" ::: ~/Work/silicoDigest/F{1..24}

