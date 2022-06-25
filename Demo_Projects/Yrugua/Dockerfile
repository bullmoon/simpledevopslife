# Base image
FROM python:3.8
LABEL maintainer="VV"
LABEL version=$TAG

ENV forkfolder /app
WORKDIR ${forkfolder}

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /tmp/requirements.txt

COPY content/ ${forkfolder}

ENTRYPOINT [ "gunicorn", "--bind", "0.0.0.0:9003", "app:app" ]
