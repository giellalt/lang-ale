#!/bin/bash

# script to generate paradigms for generating word forms
# command:
# sh generate_contlex_para.sh PATTERN
# example, when you are in ale:
# sh devtools/noun_minip.sh LAAVU | less
# sh devtools/noun_minip.sh smiergâs 
# Only get the lemma you ask for:
# sh devtools/noun_minip.sh '^smiergâs[:+]' 


LOOKUP=$(echo $LOOKUP)
HLOOKUP=$(echo $HLOOKUP)
GTLANGS=$(echo $GTLANGS)


PATTERN=$1
L_FILE="in.txt"
cut -d '!' -f1 src/fst/stems/nouns.lexc | egrep $PATTERN | tr '+' ':'| cut -d ':' -f1>$L_FILE

P_FILE="test/data/noun_paradigm.txt"

for lemma in $(cat $L_FILE);
do
 for form in $(cat $P_FILE);
 do
      echo "${lemma}${form}" | $HLOOKUP $GTLANGS/lang-ale/src/generator-gt-norm.hfstol # hfst
#      echo "${lemma}${form}" | $LOOKUP $GTLANGS/lang-ale/src/generator-gt-norm.xfst # xfst
 done
 rm -f $L_FILE
done

