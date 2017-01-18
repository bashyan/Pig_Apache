txn = load '/home/hduser/Documents/txns1.txt' using PigStorage(',') as (txnid, date, custid, amount:double, category, product, city, state, type);

groupbytype = group txn by type; 

totalsalebytype = foreach groupbytype generate group as type, SUM(txn.amount) as typesale;
 
groupbytotal = group totalsalebytype all;

totsales = foreach groupbytotal generate SUM(totalsalebytype.typesale) as totalsaleamt;

result = foreach totalsalebytype generate $0, $1, ROUND_TO(($1/totsales.totalsaleamt)*100,2);

dump result; 
