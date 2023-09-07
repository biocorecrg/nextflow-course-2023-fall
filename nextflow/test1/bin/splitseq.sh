awk '/^>/ {f="seq_"++d} {print > f}' < $1

