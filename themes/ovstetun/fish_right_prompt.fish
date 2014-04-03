function __bobthefish_right_prompt_git -d 'Display the actual git state'

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)
  set -l white (set_color white)

  set -l dirty   (command git diff --no-ext-diff --quiet --exit-code; or echo -n "$cyan ✱$normal")
  set -l staged  (command git diff --cached --no-ext-diff --quiet --exit-code; or echo -n "$green ✚$normal")
  set -l stashed (command git rev-parse --verify refs/stash > /dev/null 2>&1; and echo -n "$blue ✭$normal")
  set -l ahead   (command git branch -v 2> /dev/null | grep -Eo '^\* [^ ]* *[^ ]* *\[[^]]*\]' | grep -Eo '\[[^]]*\]$' | awk 'ORS="";/ahead/ {print " ⬆"} /behind/ {print " ⬇"}')

  test "$ahead"; and set ahead "$yellow$ahead"

  set -l new (command git ls-files --other --exclude-standard);
  test "$new"; and set new "$white ◼$normal"

  set -l flags   "$staged$dirty$stashed$ahead$new "
  test "$flags"; and set flags "$flags"

  #set -l flag_bg $lt_green
  #set -l flag_fg $dk_green
  #if test "$dirty" -o "$staged"
  #  set flag_bg $med_red
  #  set flag_fg fff
  #else
  #  if test "$stashed"
  #    set flag_bg $lt_orange
  #    set flag_fg $dk_orange
  #  end
  #end

  #__bobthefish_start_segment $flag_bg $flag_fg
  #set_color $flag_fg --bold
  echo -n -s $flags ' '
  #set_color normal

  set -l project_pwd  (__bobthefish_project_pwd)
  if test "$project_pwd"
    if test -w "$PWD"
      __bobthefish_start_segment 333 999
    else
      __bobthefish_start_segment $med_red $lt_red
    end

    echo -n -s $project_pwd ' '
  end
end

function __bobthefish_right_prompt_git2

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l white (set_color -o white)
  set -l normal (set_color normal)


end

function fish_right_prompt
  if __bobthefish_in_git
    __bobthefish_right_prompt_git
  end
  set_color $fish_color_autosuggestion[1]
  date "+%Y-%m-%d %H:%M:%S"
  set_color normal
  set -g current_bg NONE
end
