function _autonvm_find_file_node_version --description "Traverse up in directory tree to find the contained folder of an .node-version file."
  set --local dir (_file_find_up '.node-version')
  if test -e "$dir/.node-version";
    echo "$dir/.node-version"
  end
end
