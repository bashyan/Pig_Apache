book = load '$inp' using PigStorage() as (lines:chararray);

transforms = foreach book generate FLATTEN(TOKENIZE(lines)) as word;

groupbyword = group transforms by word;

countofeachword = foreach groupbyword generate group, COUNT(transforms.word);

dump countofeachword; 
