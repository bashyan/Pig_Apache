
medloads = load '/home/bashyan-ubuntu/Documents/pig/Medical_claims.txt' using PigStorage(',') as (name, dept, claim);

--dump medloads;

medgroups = group medloads by name;

--dump medgroups;

avgclaim = foreach medgroups generate $0, AVG(medloads.$2);

dump avgclaim;
