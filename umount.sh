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

fusermount -u $PHOTOFS_MOUNT_PATH
