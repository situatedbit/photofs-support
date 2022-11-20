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
require_var "${PHOTOFS_RBENV_RUBY}" "PHOTOFS_RBENV_RUBY"

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

(cd $PHOTOFS_DEPLOY_PATH/latest; RBENV_VERSION=$PHOTOFS_RBENV_RUBY gem install bundler)
(cd $PHOTOFS_DEPLOY_PATH/latest; RBENV_VERSION=$PHOTOFS_RBENV_RUBY bundle install)
(cd $PHOTOFS_DEPLOY_PATH/latest; RBENV_VERSION=$PHOTOFS_RBENV_RUBY bundle update)
