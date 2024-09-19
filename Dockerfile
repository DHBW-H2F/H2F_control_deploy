FROM alpine

RUN apk add --no-cache ansible openssh

WORKDIR /app

CMD [ "ansible-playbook" ]
