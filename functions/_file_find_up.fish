function _file_find_up --description "Traverse up in directory tree to find the contained folder of the given file"
  if [ (count $argv) -gt 0 ]
    set --local _file $argv[1]
    set --local _path "$PWD"
    while test -n "$_path"; and test "$_path" != '.'; and ! test -f "$_path/$_file"
      set _path (string split -r -m1 / $_path)[1]
    end
    echo $_path
  else
    echo "No arguments given"
  end
end