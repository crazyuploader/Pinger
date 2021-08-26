#
# Created by Jugal Kishore -- 2021
#
# Using Base Image: Alpine
FROM alpine:3.14.1

# Adding Required Package(s)
RUN apk --no-cache --update add \
    alpine-conf \
    bash \
    bash \
    bind-tools \
    curl \
    mtr \
    python3

# Run time variable(s)
ARG TIME_ZONE

# Setting TimeZone to IST
RUN setup-timezone -z $TIME_ZONE && \
    echo "TimeZone set to $TIME_ZONE"

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
