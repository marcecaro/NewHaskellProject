# Haskell Development environment setup

This project started from: https://github.com/marcecaro/NewHaskellProject

## Install  ghcup

```shell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

Add this line in **~/.profile**:

 ```shell
[ -f "/home/codespace/.ghcup/env" ] && source "/home/codespace/.ghcup/env" # ghcup-env
 ```

using `ghcup tui` **install and select** this versions:

- `HLS-1.8.0.0`
- `cabal-3.8.1.0`
- `GHC-9.0.2`: This is the lates with lts -> lts-19.24

## Setup stack

### Config
```shell 
stack config set system-ghc --global true
stack setup
stack config set resolver lts-19.24
```

### Init

[Optional] Inside the project

```shell
cd src
stack init --force
```
Check that the project build: 


```shell
cd src
stack build
```


### Install tools

```shell
./install-tools
```

*Check that all the tools were installed*

## VSCode configuration

- Install the recommended plugins


## Change Project Name

**in:**
-- Project.cabal
-- `stack init --force`
