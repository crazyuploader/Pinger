#
# Created by Jugal Kishore -- 2021
#
# Using Base Image: Alpine
FROM alpine:3.13.5

# Adding Required Package(s)
RUN apk --no-cache add \
    mtr \
    bash \
    alpine-conf \
    bind-tools \
    bash

# Setting TimeZone to IST
RUN setup-timezone -z Asia/Kolkata

# Removing Stuff(s)
RUN apk del alpine-conf

# Setting Working Directory
WORKDIR /pinger

# Copy required file(s)
COPY mtr.sh mtr.sh

COPY servers.txt servers.txt

COPY helper.sh helper.sh

# Creating Directory for logs
RUN mkdir /var/pinger

CMD [ "./helper.sh" ]
