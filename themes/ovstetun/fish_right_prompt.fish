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

  echo -n -s $flags ' '
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
