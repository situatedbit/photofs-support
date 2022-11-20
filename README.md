# Usage

## Environment Variables

```
PHOTOFS_DEPLOY_PATH
PHOTOFS_GIT_PATH
PHOTOFS_RBENV_RUBY
PHOTOFS_SOURCE_PATH
PHOTOFS_MOUNT_PATH
```

## Tagging and Deploying New Version

1. Update the GEM version.
2. Apply version tag with `tag-version.sh`.
3. Push tags to remote: `git push origin --follow-tags`
4. Deploy locally with `deploy.sh TREE-ISH`
5. (Optional) install latest photofs gem to default gemset for photo-utils

## Install PhotoFS Gem for photo-utils

In photofs directory
    gem build photofs.gemspec

In default, global gemset:
    gem install src/photofs/photofs/photofs-0.X.X.gem

## To Initialize a System

MySQL

```
# drop database DB;
create user 'username'@'localhost' identified by 'password';
create database DB character set utf8mb4 collate utf8mb4_bin;
grant all privileges on DB.* to 'DB'@'localhost';
FLUSH PRIVILEGES;

```

```
photofs init .
(photofs import images .)
(photofs import tags)
```
