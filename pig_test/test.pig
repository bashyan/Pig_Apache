

student = load '/home/bashyan-ubuntu/Downloads/part-m-00000' using PigStorage(',') as (name,stuid,pass);

--dump student;

split student into pass if pass == 'pass', fail if pass == 'fail';

--dump pass;
--dump fail;

store pass into 'passoutput';
