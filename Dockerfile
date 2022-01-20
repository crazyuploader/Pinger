#
# Created by Jugal Kishore -- 2021
#
# Using Base Image: Alpine
FROM alpine:3.15.0

# Adding Required Package(s)
RUN apk --no-cache --update add \
    mtr \
    bash \
    alpine-conf \
    bind-tools \
    bash \
    python3

# Setting TimeZone to IST
RUN setup-timezone -z Asia/Kolkata

# Removing Stuff(s)
RUN apk del alpine-conf

# Setting Working Directory
WORKDIR /pinger

# Copy required file(s)
COPY mtr.sh mtr.sh

COPY mtr.py mtr.py

COPY servers.txt servers.txt

COPY helper.sh helper.sh

# Creating Directory for logs
RUN mkdir /var/pinger

CMD [ "./helper.sh" ]
