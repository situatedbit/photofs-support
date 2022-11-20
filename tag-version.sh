#!/bin/bash
#
# applies tag to HEAD based on GEM version
#

# require_var "${VARIABLE}" "VARIABLE"
require_var()
{
  if [[ -z "${1}" ]]; then
    echo "Missing ${2} environment variable";
    exit 2;
  fi
}

require_var "${PHOTOFS_GIT_PATH}" "PHOTOFS_GIT_PATH"
require_var "${PHOTOFS_RBENV_RUBY}" "PHOTOFS_RBENV_RUBY"

VERSION=$(RBENV_VERSION=$PHOTOFS_RBENV_RUBY ruby $PHOTOFS_GIT_PATH/version.rb)

git -C $PHOTOFS_GIT_PATH tag -a "v$VERSION" -m "version $VERSION"
