FROM alpine:3.5

LABEL description="Damn Vulnerable GraphQL Application"
LABEL github="https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application"
LABEL maintainers="Dolev Farhi & Connor McKinnon"


ARG TARGET_FOLDER=/opt/dvga
WORKDIR $TARGET_FOLDER/

RUN apk add --update curl 
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

COPY requirements.txt /opt/dvga/
RUN pip install -r requirements.txt

ADD core /opt/dvga/core
ADD db /opt/dvga/db
ADD static /opt/dvga/static
ADD templates /opt/dvga/templates

COPY app.py /opt/dvga
COPY config.py /opt/dvga
COPY setup.py /opt/dvga/
COPY version.py /opt/dvga/

RUN python setup.py

EXPOSE 5013/tcp
CMD ["python3", "app.py"]
