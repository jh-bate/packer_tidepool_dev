#!/bin/sh -eu

TIDEPOOLDIR="$HOME/tidepool/development"
DEV_REPO="https://github.com/tidepool-org/development.git"

echo "==> installing tidepool development into ${TIDEPOOLDIR})"

git clone ${DEV_REPO} ${TIDEPOOLDIR}

export PATH=${PATH}:${TIDEPOOLDIR}/bin

tidepool help
