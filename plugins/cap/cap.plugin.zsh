_cap_does_task_list_need_generating () {
  if [ ! -f .cap_tasks~ ]; then return 0;
  else
    accurate=$(stat -c%Z .cap_tasks~)
    changed=$(stat -c%Z config/deploy.rb)
    return $(expr $accurate '>=' $changed)
  fi
}

_cap () {
  if [ -f config/deploy.rb ]; then
    if _cap_does_task_list_need_generating; then
     echo "\nGenerating .cap_tasks~..." > /dev/stderr
     bundle exec cap -T -q | grep '#' | cut -d ' ' -f 2 | sort > .cap_tasks~
    fi
    compadd `cat .cap_tasks~`
  fi
}

compdef _cap cap
