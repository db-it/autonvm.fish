function autonvm_load --on-variable="PWD"
    set --function default_node_version
    if [ -n "$nvm_default_version" ]
        set default_node_version (_autonvm_resolve_version $nvm_default_version)
    end
    set --function current_node_version (nvm current)
    set --function nvmrc_path (_autonvm_find_file_nvmrc)
    set --function node_version_path (_autonvm_find_file_node_version)
    set --function required_node_version
    set --query autonvm_no_prompt_for_install || set --global autonvm_no_prompt_for_install 0

    if [ $autonvm_debug > 0 ]
        set_color brblack
        echo "nvm.fish default version (\$nvm_default_version): $default_node_version"
        echo "current node version: $current_node_version"
        echo "path of .nvmrc: $nvmrc_path"
        echo "path of .node-version: $node_version_path"
        echo "autonvm_no_prompt_for_install: $autonvm_no_prompt_for_install"
        set_color normal
    end

    if [ -n "$nvmrc_path" ]
        set required_node_version (cat $nvmrc_path)
    else if [ -n "$node_version_path" ]
        set required_node_version (cat $node_version_path)
    else if [ -n "$default_node_version" ]; and [ "$current_node_version" != "$default_node_version" ]
        set_color bryellow
        echo "Reverting to default Node version"
        set_color normal

        nvm use default
        return
    end

    if [ $autonvm_debug > 0 ]
        set_color brblack
        echo "Required Node version (.nvmrc or .node_version): $required_node_version"
         if [ -n "$(nvm list $required_node_version)" ]
            echo "Required Node version installed?: true"
         else
            echo "Required Node version installed?: false"
         end
        set_color normal
    end

    if test -n "$required_node_version"
        # "nvm list $version" checks if the version is installed
        if [ -z "$(nvm list $required_node_version)" ]; and [ $autonvm_no_prompt_for_install -eq 0 ]
            if _promptUserForConfirmation "Required node version $required_node_version (.nvmrc or .node_version) not installed. Install now?"
                nvm install $required_node_version
            else
                set --global autonvm_no_prompt_for_install 1
                [ $autonvm_debug > 0 ] && echo "Set autonvm_no_prompt_for_install $autonvm_no_prompt_for_install"
                set_color bryellow
                echo "Using node version: $current_node_version"
                set_color normal
            end
        else if [ "$current_node_version" != "$required_node_version" ]; and [ -n "$(nvm list $required_node_version)" ]
            nvm use $required_node_version
        end
    end
end
