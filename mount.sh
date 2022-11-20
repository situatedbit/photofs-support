#!/bin/bash

# require_var "${VARIABLE}" "VARIABLE"
require_var()
{
  if [[ -z "${1}" ]]; then
    echo "Missing ${2} environment variable";
    exit 2;
  fi
}

require_var "${PHOTOFS_MOUNT_PATH}" "PHOTOFS_MOUNT_PATH"
require_var "${PHOTOFS_SOURCE_PATH}" "PHOTOFS_SOURCE_PATH"
require_var "${PHOTOFS_DEPLOY_PATH}" "PHOTOFS_DEPLOY_PATH"
require_var "${PHOTOFS_RBENV_RUBY}" "PHOTOFS_RBENV_RUBY"

(cd $PHOTOFS_DEPLOY_PATH/latest; RBENV_VERSION=$PHOTOFS_RBENV_RUBY bundler exec ruby mount.rb $PHOTOFS_MOUNT_PATH -o daemon,source=$PHOTOFS_SOURCE_PATH)
