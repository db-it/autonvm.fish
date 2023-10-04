function autonvm_load --on-variable="PWD"
    set --local default_node_version
    if test -n "$nvm_default_version"
        set default_node_version (_autonvm_resolve_version $nvm_default_version)
    end
    set --local current_node_version (nvm current)
    set --local nvmrc_path (_autonvm_find_file_nvmrc)
    set --local node_version_path (_autonvm_find_file_node_version)
    set --local local_node_version

    # debug
    # echo "default_node_version: $default_node_version"
    # echo "current_node_version: $current_node_version"
    # echo "nvmrc_path: $nvmrc_path"
    # echo "node_version_path: $node_version_path"

    if test -n "$nvmrc_path"
        set local_node_version (cat $nvmrc_path)
    else if test -n "$node_version_path"
        set local_node_version (cat $node_version_path)
    else if test -n "$default_node_version"; and test "$current_node_version" != "$default_node_version"
        set_color bryellow
        echo "Reverting to default Node version"
        set_color normal

        nvm use default
        return
    end

    # debug
    # echo "local_node_version: $local_node_version"

    if test -n "$local_node_version"
        # "nvm list $version" checks if the version is installed
        if test -z "$(nvm list $local_node_version)"
            if _promptUserForConfirmation "Required node version $local_node_version (.nvmrc or .node_version) not installed. Install now?"
                nvm install $local_node_version
            else
                set_color bryellow
                echo "Using node version: $current_node_version"
                set_color normal
            end
        else if test "$current_node_version" != "$local_node_version"
            nvm use $local_node_version
        end
    end
end