FROM amazon/aws-cli:latest

RUN yum install -y jq
    

WORKDIR /scripts
COPY ./scripts /scripts


ENTRYPOINT [ "/bin/bash" ]