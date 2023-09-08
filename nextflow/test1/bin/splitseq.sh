#!/bin/bash
#
# This script will split a fasta files in multiple files


awk '/^>/ {f="seq_"++d} {print > f}' < $1

