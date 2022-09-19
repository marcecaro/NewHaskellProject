cups:
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
	stack ls snapshots --lts remote

bootstrap:
	stack config set system-ghc --global true
	stack config set resolver lts-19.24
	stack setup
	stack install hlint

build: src
	stack build

run: build
	cd examples; stack ghc -- -fplugin=CoreDump.Plugin basic.hs; cd -