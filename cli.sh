#!/bin/bash

# require_var "${VARIABLE}" "VARIABLE"
require_var()
{
  if [[ -z "${1}" ]]; then
    echo "Missing ${2} environment variable";
    exit 2;
  fi
}

require_var "${PHOTOFS_DEPLOY_PATH}" "PHOTOFS_DEPLOY_PATH"
require_var "${PHOTOFS_RBENV_RUBY}" "PHOTOFS_RBENV_RUBY"

(cd $PHOTOFS_DEPLOY_PATH/latest; RBENV_VERSION=$PHOTOFS_RBENV_RUBY bundler exec ruby cli.rb "$@")
