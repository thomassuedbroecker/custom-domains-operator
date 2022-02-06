###########
# BUILD   #
###########
FROM quay.io/app-sre/boilerplate:image-v2.1.0 AS builder

RUN mkdir /src

# Copy and download the dependecies so that they are cached locally in the stages.
COPY go.mod /src
COPY go.sum /src
RUN more /src/go.mod
RUN more /src/go.sum

WORKDIR /src
RUN go mod download

COPY . /src

RUN make gobuild

################
# PRODUCTION   #
################
FROM registry.access.redhat.com/ubi8/ubi-minimal:latest
# FROM docker.hub/golang:1.16-alpine

RUN pwd

COPY ./build/bin/entrypoint.sh /usr/local/bin
COPY ./build/bin/user_setup.sh /usr/local/bin

# RUN more /usr/local/bin/entrypoint.sh 
# RUN more /usr/local/bin/user_setup.sh 

# ENV OPERATOR=/usr/local/bin/custom-domains-operator \
#    USER_UID=1001 \
#    USER_NAME=custom-domains-operator
# ENV OPERATOR_BIN=custom-domains-operator

# COPY --from=builder /src/build/_output/bin/${OPERATOR_BIN} /usr/local/bin/${OPERATOR_BIN}
RUN  mkdir /usr/local/bin/custom-domains-operator
COPY --from=builder /src/build/_output/bin/custom-domains-operator /usr/local/bin/custom-domains-operator
RUN  bash /usr/local/bin/user_setup.sh

# ENTRYPOINT ["/usr/local/bin/entrypoint"]
# USER ${USER_UID}

USER 1001

CMD ["/bin/bash","/usr/local/bin/entrypoint.sh"]
