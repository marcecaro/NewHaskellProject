# Haskell Development environment setup

This project started from: https://github.com/marcecaro/NewHaskellProject

## Install  ghcup

```shell
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

Add this line in **~/.profile**:

 ```shell
 [ -f "/home/codespace/.ghcup/env" ] && source "/home/codespace/.ghcup/env" # ghcup-env` in *~/.profile* 
 ```

using `ghcup tui` **install and select** this versions:

- `HLS-1.8.0.0`
- `cabal-3.8.1.0`
- `GHC-9.0.2`: This is the lates with lts -> lts-19.24

**~/.stack/global-project/stack.yaml**
```yaml
packages: []
resolver: lts-19.24
extra-deps:
   - ghc-lib-parser-9.2.4.20220729@sha256:02c229a122d698f055615f2794fbcb01ce4241aaf16ee990068189193c61e228,12741
   - ghc-lib-parser-ex-9.2.1.1@sha256:5c8a31fd7fa1f7c4f4f191c869007bf64eb2e12575f6874cd59ebeec83ae177d,3493
```


## Setup stack

### Config
```shell 
stack config set system-ghc --global true
stack config set resolver lts-19.24
```

### Setup
```shell
stack setup
```

### Init
Inside the project
```shell
cd src
stack init --force
```

### Install tools

```shell
stack install hlint
stack install ghcid
stack install haskell-dap ghci-dap haskell-debug-adapter
```

```shell
stack install stylish-haskell hindent
```

## VSCode configuration

- Install the recommended plugins


## Change Project Name

**in:**
-- Project.cabal
-- `stack init --force`
