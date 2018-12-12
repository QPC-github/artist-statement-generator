#!/usr/bin/env bash

VOCAB_SIZE=10000
VOCAB_FILE=/data/local/vocab_lower_${VOCAB_SIZE}.txt
MODEL=weights.lstm128.batch32.glove300.sample5.vocab10000.default.hdf5

python3 /app/src/artstat/models/onehot.py sample \
    --vocab_file=${VOCAB_FILE} \
    --vocab_is_lowercase=True \
    --seqlen=32 \
    --vocab_size=${VOCAB_SIZE} \
    --model_file=/app/notebooks/checkpoints/m2/weights.lstm128.batch32.glove300.sample5.vocab10000.default.hdf5 \
    --num_words_to_sample=200 \
    --init_text="Mary had a little lamb, its exterior attributes white and cold. And everywhere that Mary went
    the lamb would also go."

# weights.lstm256.batch64.glove300.sample5.vocab10000.default.hdf5 \