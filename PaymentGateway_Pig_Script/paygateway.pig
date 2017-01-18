paygate = load '/home/bashyan-ubuntu/Documents/pig/PaymentGateway.txt' using PigStorage(',') as (gateway, rate:float);
weblog = load '/home/bashyan-ubuntu/Documents/pig/WebLog.txt' using PigStorage(',') as (user, gateway, time);

--dump weblog;

joingate = join weblog by $1, paygate by $0;

--dump joingate;

tempgate = foreach joingate generate $0, $1, $4;

--dump tempgate;

groupuser = group tempgate by user;

--dump groupuser;


avgrate = foreach groupuser generate $0,AVG(tempgate.$2);

--dump avgrate;

ReliableGatewayUser = filter avgrate by ($1>90);

dump ReliableGatewayUser;
