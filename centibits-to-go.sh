sqlite3 centibits.db "select g1.a, centibits/100 from gram1s g1;select g2.a || ',' || g2.b, g2.centibits / 100 from gram2s g2 join gram1s g1 on g2.b=g1.a where g1.centibits > 2 * g2.centibits and g2.a <= 25697 and g2.b <= 25697;select g3.a || ',' || g3.b || ',' || g3.c, g3.centibits / 100 from gram3s g3 join gram2s g2 on g3.b = g2.a and g3.c = g2.b where g2.centibits > 2 * g3.centibits and g3.a <= 25697 and g3.b <= 25697 and g3.c <= 25697;" | split -l 1000000 -d -a 3 - shard-
for s in shard-* ; do ruby -rjson -e 'STDOUT.print(Hash[STDIN.readlines.map {|line| k,v = *line.strip.split("|") ; [k,v] }].to_json)' < $s > $s.json ; done
