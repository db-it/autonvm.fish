function _promptUserForConfirmation -a message
  if test -z $message
    set_color brred
    echo "First argument 'message' is required for function '_promptUserForConfirmation'."
    set_color normal
    return 1
  end
  while true
    read --local --prompt "set_color brmagenta; echo '🤔 $message [y/N] '; set_color normal" confirm
    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end