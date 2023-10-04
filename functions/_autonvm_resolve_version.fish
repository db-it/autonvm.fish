function _autonvm_resolve_version --description "Extracts the concrete version of the nvm list output."
    if [ (count $argv) -gt 0 ]
        set --local _node_version $argv[1]
        set --local _nvm_list_output (nvm list $_node_version)
        set --local _extracted_version (string match '\s(v[\.0-9]*)\s' --groups-only --regex $_nvm_list_output)
        echo "$_extracted_version"
    else
        echo "No arguments given"
    end
end