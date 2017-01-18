year1 = load '/home/bashyan-ubuntu/Documents/pig/2000.txt' using PigStorage(',') as (prdid, prdname, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double);
year1sum = foreach year1 generate $0, $1, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);


year2 = load '/home/bashyan-ubuntu/Documents/pig/2001.txt' using PigStorage(',') as (prdid, prdname, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double);
year2sum = foreach year2 generate $0, $1, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);

year3 = load '/home/bashyan-ubuntu/Documents/pig/2002.txt' using PigStorage(',') as (prdid, prdname, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sep:double, oct:double, nov:double, dec:double);
year3sum = foreach year3 generate $0, $1, ($2+$3+$4+$5+$6+$7+$8+$9+$10+$11+$12+$13);

joinedbags = join year1sum by $0, year2sum by $0, year3sum by $0;
totaldata = foreach joinedbags generate $0, $1, $2, $5, $8;

growthbyyear = foreach totaldata generate $0, $1, $2, $3, $4, (($3-$2)/$2)*100, (($4-$3)/$3)*100;
growthavg = foreach growthbyyear generate $0, $1, $2, $3, $4, $5, $6, (($5+$6)/2);
filtergrowth10 = filter growthavg by ($7>10);
filtergrowth5 = filter growthavg by ($7<-5);
--dump filtergrowth10;
--dump filtergrowth5;

-- top5

totalprdsale = foreach totaldata generate $0, $1, $2, $3, $4, ($2+$3+$4);
top5descend =  order totalprdsale by $5 desc;
top5 = limit top5descend 5;
top5ascend =  order totalprdsale by $5 asc;
last5 = limit top5ascend 5;

dump last5;

























