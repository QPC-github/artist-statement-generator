#!/usr/bin/env bash

GLOVE_DIMS=300
GLOVE_FILE=/data/shared/glove.6B/glove.6B.${GLOVE_DIMS}d.txt \

VOCAB_SIZE=10000
VOCAB_FILE=/data/local/vocab_lower_${VOCAB_SIZE}.txt

CHECKPOINT_DIR=/app/notebooks/checkpoints/m2
if [[ ! -f ${CHECKPOINT_DIR} ]]; then
  mkdir -p ${CHECKPOINT_DIR}
fi


TRAINING_DATA_DIR=/data/local/artstat/train

python3 /app/src/artstat/models/onehot.py train \
--glove_dims=$GLOVE_DIMS \
--glove_file=$GLOVE_FILE \
--vocab_file=$VOCAB_FILE \
--checkpoint_dir=$CHECKPOINT_DIR \
--training_data_dir=$TRAINING_DATA_DIR \
--vocab_is_lowercase=True \
--vocab_size=$VOCAB_SIZE \
--seqlen=32 \
--sample_size=5 \
--batch_size=32 \
--learning_rate_decay_period=10 \
--learning_rate_decay_rate=0.7 \
--learning_rate_initial=0.01 \
--learning_rate_floor=0.00005 \
--dropout_rate=0.1 \
--dense_layers=6 \
--dense_size=300 \
--lstm_size=128 \
--lstm_layers=1 \
--num_epochs=1000 \
--starting_epoch=0 \
--epochs_per_dataset=20000
##--starting_model_file=/app/notebooks/checkpoints/m2/weights.lstm1024.batch128.glove300.sample10.vocab10000.default.hdf5

#--starting_model_file=/app/notebooks/checkpoints/m2/weights.lstm1024.batch128.glove300.sample10.vocab10000.default.hdf5
#--training_max_files=3000 \

#lr=0.01, period=10, rate=0.7, dropout=0.1, floor=0.00005

#after epoch 49, lr=0.0024; loss=1.1636, acc=0.8712