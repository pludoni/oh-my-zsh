#RVM settings
#if [[ -s ~/.rvm/scripts/rvm ]] ; then
#RPS1="%{$fg[yellow]%}rvm:%{$reset_color%}%{$fg[red]%}\$(~/.rvm/bin/rvm-prompt)%{$reset_color%} $EPS1"
#fi

# vim: set ft=zsh

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[cyan]%}"

ssh_agent_status() {
  if [ -n "$SSH_AGENT_PID" ]; then
    out="$(ssh-add -l 2>/dev/null)"
    if [ $? -eq 0 ]; then
    echo "%{$fg_bold[green]%}§%{$reset_color%}"
    else
    echo "$fg_bold[red]§*"
    fi
  fi
}

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  local short="%25>..>${cb}%<<"
    if [ -n "$cb" ]; then
      echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX${short}$ZSH_THEME_GIT_PROMPT_SUFFIX"
        fi
}




# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
# Only proceed if there is actually a commit.
    if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
# Get the last commit.
      last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
        now=`date +%s`
        seconds_since_last_commit=$((now-last_commit))

# Totals
        MINUTES=$((seconds_since_last_commit / 60))
        HOURS=$((seconds_since_last_commit/3600))

# Sub-hours and sub-minutes
        DAYS=$((seconds_since_last_commit / 86400))
        SUB_HOURS=$((HOURS % 24))
        SUB_MINUTES=$((MINUTES % 60))

        if [[ -n $(git status -s 2> /dev/null) ]]; then
          if [ "$MINUTES" -gt 30 ]; then
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
              elif [ "$MINUTES" -gt 10 ]; then
              COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
          else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
              fi
        else
          COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi

            if [ "$HOURS" -gt 24 ]; then
              echo "($COLOR${DAYS}d%{$reset_color%})"
                elif [ "$MINUTES" -gt 60 ]; then
                echo "($COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%})"
            else
              echo "($COLOR${MINUTES}m%{$reset_color%})"
                fi
                fi
                fi
}


#PROMPT='$(git_time_since_commit)$(git_custom_status)%{$fg_bold[yellow]%}[%~% ]%{$reset_color%}%B$%b '
PROMPT='$(git_custom_status)$(ssh_agent_status)%{$fg_bold[blue]%}{%n@%m}%{$fg_bold[yellow]%}[%~% ]%{$reset_color%}%B$%b '
RPROMPT="" #$fg[gray]${SSH_TTY:+[%n@%m]}%{$reset_color%}"
