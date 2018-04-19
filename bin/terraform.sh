#!/bin/sh

docker run -it -w /opt/terraform -v`pwd`:/opt/terraform hashicorp/terraform:light $*
