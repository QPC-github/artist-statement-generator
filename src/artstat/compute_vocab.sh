#!/usr/bin/env bash

#Usage: vocab.py [OPTIONS] TEXTPATH
#
#  Loads texts recursively from TEXTPATH and outputs the vocabulary.
#
#Options:
#  --normalize_unicode TEXT        Convert Unicode chars, e.g punctuation, to
#                                  their closest ASCII counterparts. Def: true
#  --maxnumfiles INTEGER           Only process at most this many files. Set to
#                                  zero or don't specify to process all files.
#                                  Def: all files.
#  --outputfile TEXT               If provided, will write out a list of
#                                  vocabulary words to this file, one per line.
#  --vocabsize INTEGER             Max words to output in vocab. Default=0,
#                                  output all
#  --output_word_counts_file TEXT  If provided, write a full histogram of word
#                                  counts to this filename.
#  --sortwords TEXT                When writing to file, sort words by
#                                  frequency descending. Def: true.
#  --lowercase TEXT                Generate lowercase words only.
#  --quiet TEXT                    Suppress stdout output
#  --help                          Show this message and exit.

VOCABSIZE=10000

TEMPDIR=/data/local/tmp
if [[ ! -e $TEMPDIR ]]; then
  mkdir $TEMPDIR
fi

python3 -m artstat.vocab \
    --outputfile /data/local/vocab_lower_${VOCABSIZE}.txt \
    --vocabsize ${VOCABSIZE} \
    --output_word_counts_file /data/local/vocab_lower_hist_${VOCABSIZE}.txt \
    --lowercase True \
    /data/local/artstat
