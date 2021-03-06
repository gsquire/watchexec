VER=$(shell grep version Cargo.toml | head -n1 | grep -Eow '".+"' | sed 's/"//g')

debug:	src/* Cargo.toml
		@cargo build

release: src/* Cargo.toml
		@cargo build --release

clean:
		@cargo clean

install: release
		@cp target/release/watchexec /usr/bin

uninstall:
		@rm /usr/bin/watchexec

dist-osx: release
		@tar -cz -C target/release -f target/release/watchexec_osx_$(VER).tar.gz watchexec
		@shasum -a 256 target/release/watchexec_osx_$(VER).tar.gz
