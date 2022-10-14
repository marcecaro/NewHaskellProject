snapshots:
	stack ls snapshots --lts remote
	stack ls snapshots --nightly remote

build:
	stack build
