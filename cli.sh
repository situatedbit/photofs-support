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
require_var "${PHOTOFS_RVM_GEMSET}" "PHOTOFS_RVM_GEMSET"
require_var "${PHOTOFS_RVM_RUBY}" "PHOTOFS_RVM_RUBY"

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  # First try to load from a user install
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

rvm use $PHOTOFS_RVM_RUBY@$PHOTOFS_RVM_GEMSET >/dev/null

BUNDLE_GEMFILE="$PHOTOFS_DEPLOY_PATH/latest/Gemfile" bundler exec ruby $PHOTOFS_DEPLOY_PATH/latest/cli.rb "$@"
