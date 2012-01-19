_rails(){
  if (( CURRENT > 2 )); then
    # Remember the subcommand name
    local cmd=${words[2]}
    # Set the context for the subcommand.
    curcontext="${curcontext%:*:*}:rails-$cmd"
    (( CURRENT-- ))
    shift words
    # Run the completion for the subcommand
    _rails_cmd_$cmd
  else
    local hline
    local -a cmdlist
    _call_program help-commands rails | grep "^ \w" | sed 's/^[ \t]*//;s/[ \t]*$//' | while read -A hline; do
    (( ${#hline} < 2 )) && continue
    [[ $hline[1] = (#i)rails ]] && continue
    cmdlist=($cmdlist "${hline[1]}:${hline[2,-1]}")
  done
  _describe -t rails-commands 'Rails commands' cmdlist
fi
}
_rails_does_generator_list_need_generating () {
  if [ ! -f .rails_generators ]; then return 0;
  else
    accurate=$(stat -c%Z .rails_generators)
    changed=$(stat -c%Z .rails_generators)
    return $(expr $accurate '>=' $changed)
  fi
}

_rails_cmd_generate () {
    if _rails_does_generator_list_need_generating; then
      echo "\nGenerating .rails_generators..." > /dev/stderr
      rails generate | egrep "^  [a-z0-9:]" | sort > .rails_generators
    fi
    compadd `cat .rails_generators`
}
_rails_cmd_plugin () {
}
_rails_cmd_console () {
}
_rails_cmd_server () {
}
_rails_cmd_dbconsole () {
}
_rails_cmd_application () {
}
_rails_cmd_profiler () {
}
_rails_cmd_runner () {
}
_rails_cmd_destroy () {
}
_rails_cmd_new () {
}
_rails_cmd_benchmarker () {
}

compdef _rails rails
