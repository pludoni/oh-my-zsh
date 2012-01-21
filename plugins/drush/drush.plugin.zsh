_drush () {
  compadd `drush | egrep '^ ([a-z][a-z\-]+)' -o`
}

compdef _drush drush
