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
    _call_program help-commands rails | while read -A hline; do
    (( ${#hline} < 2 )) && continue
    [[ $hline[1] = (#i)rails ]] && continue
    cmdlist=($cmdlist "${hline[7]}:${hline[8,-1]}")
  done
  _describe -t rails-commands 'Rails command' cmdlist
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
  if [ -f script/rails ]; then
    if _rails_does_generator_list_need_generating; then
      echo "\nGenerating .rails_generators..." > /dev/stderr
      rails generate | cut -d ' ' -f 3 | grep ".:." > .rails_generators
    fi
    compadd `cat .rails_generators`
  fi
}

compdef _rails rails
