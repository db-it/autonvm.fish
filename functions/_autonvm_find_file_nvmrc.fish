function _autonvm_find_file_nvmrc --description "Traverse up in directory tree to find the contained folder of an .npmrc file."
  set --local dir (_file_find_up '.nvmrc')
  if test -e "$dir/.nvmrc";
    echo "$dir/.nvmrc"
  end
end
