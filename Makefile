snapshots:
	stack ls snapshots --lts remote

build: src
    cd src
	stack build
