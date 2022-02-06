#!/bin/sh -e

export OPERATOR=/usr/local/bin/custom-domains-operator
exec ${OPERATOR} $@
