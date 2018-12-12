FROM tensorflow/tensorflow:1.10.0-py3
#FROM tensorflow/tensorflow:latest-gpu-py3

ENV PYTHONPATH=/app/src:$PYTHONPATH
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

################################################################################
# Install Google Cloud SDK
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

# Python packages
RUN pip install nltk tqdm unidecode click h5py pytest
RUN pip install regex

RUN pip install terminado jupyter
RUN pip install jupyter-emacskeys

RUN pip install google-cloud-datastore google-cloud-storage
RUN pip install python-box

################################################################################
WORKDIR /app

VOLUME /app
VOLUME /data
VOLUME /config

ARG GCLOUD_AUTH_KEY
ADD $GCLOUD_AUTH_KEY /gcloud-auth/key.json

ENV GOOGLE_APPLICATION_CREDENTIALS="/gcloud-auth/key.json"

RUN gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
RUN gcloud config set project shopify-data-ml-platform-exp



################################################################################
CMD python -m jupyter notebook --allow-root \
    --ip=0.0.0.0 --notebook-dir=notebooks --port=9999

EXPOSE 9999








