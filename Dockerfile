#
# Standard image (beets installed)
#

FROM elfalem/beets-docker:base
MAINTAINER elfalem <elfalem@gmail.com>

RUN pip install beets

USER beets
