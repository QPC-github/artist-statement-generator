import os

import tensorflow as tf
from tensorflow.keras.callbacks import ModelCheckpoint


class GSModelCheckpoint(tf.keras.callbacks.Callback):
    """
    Wrapper around ModelCheckpoint that adds support for GCS paths.

    For GCS paths, it has the nested ModelCheckpoint write to a local temp file.
    On epoch end, after ModelCheckpoint.on_epoch_end has been invoked, it checks to see
    whether the temp file changed from the last time and if so, uploads it to GCS.

    For local paths, it simply delegates to nested ModelCheckpoint callback.
    """

    def __init__(self, filepath: str, monitor='val_loss', verbose=0, save_best_only=False, save_weights_only=False,
                 mode='auto', period=1):

        super().__init__()
        self.filepath = filepath
        self.nested_filepath = filepath
        self.is_cloud = False
        self.stat = None  # keep last known stat of the temp file

        if filepath.index("gs://") == 0:
            self.nested_filepath = "/tmp/123.hdf5"
            self.is_cloud = True
            self.has_file_changed()  # ignoring return value; just to update self.stat

        self.nested_callback = ModelCheckpoint(self.nested_filepath,
                                               monitor=monitor,
                                               verbose=verbose,
                                               save_best_only=save_best_only,
                                               save_weights_only=save_weights_only,
                                               mode=mode,
                                               period=period)

    def has_file_changed(self):
        try:
            newstat = os.stat(self.nested_filepath)
            if self.stat != newstat:
                self.stat = newstat
                return True
        except FileNotFoundError:
            pass
        return False

    def on_epoch_end(self, epoch, logs=None):
        self.nested_callback.on_epoch_end(epoch, logs)
        if not self.is_cloud:
            return

        if self.has_file_changed():
            # TODO: upload to gcs
            pass
