#!/bin/bash
# deploy.sh GIT-TREE-ISH
TREEISH=$1

# require_var "${VARIABLE}" "VARIABLE"
require_var()
{
  if [[ -z "${1}" ]]; then
    echo "Missing ${2} environment variable";
    exit 2;
  fi
}

require_var "${PHOTOFS_DEPLOY_PATH}" "PHOTOFS_DEPLOY_PATH"
require_var "${PHOTOFS_GIT_PATH}" "PHOTOFS_GIT_PATH"
require_var "${PHOTOFS_RVM_GEMSET}" "PHOTOFS_RVM_GEMSET"
require_var "${PHOTOFS_RVM_RUBY}" "PHOTOFS_RVM_RUBY"

if [[ -z ${TREEISH}  ]]; then
  echo "Missing GIT-TREE-ISH argument."
  exit 2;
fi

mkdir -pv $PHOTOFS_DEPLOY_PATH
rm -rf $PHOTOFS_DEPLOY_PATH/$TREEISH $PHOTOFS_DEPLOY_PATH/$TREEISH.zip

git -C $PHOTOFS_GIT_PATH archive --format zip --output $PHOTOFS_DEPLOY_PATH/$TREEISH.zip $TREEISH
mkdir -p $PHOTOFS_DEPLOY_PATH/$TREEISH

unzip $PHOTOFS_DEPLOY_PATH/$TREEISH.zip -d $PHOTOFS_DEPLOY_PATH/$TREEISH

rm -fv $PHOTOFS_DEPLOY_PATH/latest
ln -sv $PHOTOFS_DEPLOY_PATH/$TREEISH $PHOTOFS_DEPLOY_PATH/latest

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

(cd $PHOTOFS_DEPLOY_PATH/latest; gem install bundler)
(cd $PHOTOFS_DEPLOY_PATH/latest; bundle install)
(cd $PHOTOFS_DEPLOY_PATH/latest; bundle update)
