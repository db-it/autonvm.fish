# autonvm.fish

Automatic node version switching on directory change for the Node.js version manager [nvm.fish](https://github.com/jorgebucaran/nvm.fish).

Calling `nvm use` automatically in a directory with a `.nvmrc` or `.node-version` file.

This is a pure fish implementation and therefore no bash converting tools are required.

- 100% pure Fish—so simple to contribute to or tweak
- `.node-version` and `.nvmrc` support
- No setup needed—it just works!
- Promts for installation of the required node version (by .nvmrc or .node_version file)
    ```console
    ><> cd path/to/your/project
    🤔 Required node version v16 (.nvmrc or .node_version) not installed. Install now? [y/N]
    y
    Installing Node v16.20.2 lts/gallium...
    ```


## Installation

Requires [nvm.fish](https://github.com/jorgebucaran/nvm.fish/tree/main#installation):

```sh
fisher install jorgebucaran/nvm.fish
```

Install with [Fisher](https://github.com/jorgebucaran/fisher):

```sh
fisher install db-it/autonvm.fish
```

## How it works

When the variable `$PWD` changes, `autonvm.fish` first looks for an `.nvmrc` file and then for a `.node-version` file.
If one of the two files is found in the current directory, it checks if the required version is installed.
If this is the case, `nvm use` is called with the version found in one of the two files.
Otherwise, you will be asked to install the required version.

If none of the files is found in the current directory, `autonvm.fish` moves up the directory tree until one is found. 
Otherwise, the default version is used if it is set.

## Debugging

Enable debug outputs for current shell session:
```sh
set autonvm_debug 1
```

Disable debug outputs for current shell session:
```sh
set -e autonvm_debug
```