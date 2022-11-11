APT=sudo apt install -y
APT-U=sudo apt update -y
TMPDIR := $(shell mktemp -d)
GC=git clone --depth 1 # shallow git clone (just download)

all: emacs

install: debian emacs rice

clean:
	rm -rf ~/.icons/capitaine-cursors ~/.themes/* bin #~/dotfiles/emacs 

# system

guix: emacs
	stow guix shepherd bash git ssh

debian:
	$(APT) git htop tree stow pandoc screenfetch bashtop cmake libvterm0 libtool-bin

# emacs

emacs: spacemacs
	stow emacs

spacemacs: emacs/.emacs.d emacs/.spacemacs.d

emacs/.emacs.d:
	git clone https://github.com/syl20bnr/spacemacs $@

emacs/.spacemacs.d:
	git clone https://github.com/BenjaminSaintCyr/.spacemacs.d $@

# prog

node:
	$(APT) nodejs npm
	npm config set prefix '~/.local/'
	npm install -g eslint typescript typescript-formatter typescript

python:
	$(APT) python3 python3-pip

clojure:
	$(APT) clojure leiningen

clisp:
	$(APT) sbcl slime
	curl -o /tmp/ql.lisp http://beta.quicklisp.org/quicklisp.lisp
	sbcl --no-sysinit --no-userinit --load /tmp/ql.lisp \
       --eval '(quicklisp-quickstart:install :path "~/.quicklisp")' \
       --eval '(ql:add-to-init-file)' \
       --quit

# Programming utilities

docker:
	$(APT) ca-certificates curl gnupg lsb-release
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	$(APT-U)
	$(APT) docker-ce docker-ce-cli containerd.io docker-compose-plugin

	sudo usermod -aG docker ${USER}

kvm:
	sudo modprobe kvm
	sudo modprobe kvm_intel
	sudo usermod -aG kvm $USER

lttng:
	$(APT) lttng-tools lttng-modules-dkms liblttng-ust*


~/.cargo/env: # rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	source "$HOME/cargo/env"
	rustup install nightly
	echo "# rust" >> .bashrc
	echo "export PATH=~/.cargo/bin/:$PATH" >> .bashrc
	echo "source "$HOME/cargo/env"" >> .bashrc


rustup: ~/.cargo/env

rust: rustup 

# rice

rice: ~/.icons/capitaine-cursors ~/.themes/Orchis eww
	$(APT) numix-icon-theme-circle polybar

~/.icons/capitaine-cursors:
	$(APT) inkscape x11-apps
	$(GC) https://github.com/keeferrourke/capitaine-cursors.git $(TMPDIR)/cursor
	cd $(TMPDIR)/cursor && ./build.sh
	mkdir -p ~/.icons/capitaine-cursors
	cp -pr $(TMPDIR)/cursor/dist/dark/* ~/.icons/capitaine-cursors


~/.themes/Orchis:
	$(GC) https://github.com/vinceliuice/Orchis-theme.git $(TMPDIR)/theme
	cd $(TMPDIR)/theme && ./install.sh

# ** eww
/tmp/eww:
	$(GC) --branch v0.4.0 https://github.com/elkowar/eww $@

/tmp/eww/target/release/eww:
	$(APT) libgtk-3-dev libgtk-layer-shell-dev
#	-rustup component add rust-src rustc-dev llvm-tools-preview
#	-cargo +nightly install racer
	(cd /tmp/eww && cargo build --release --no-default-features) # --features=wayland
	chmod +x $@

bin/eww: rust /tmp/eww /tmp/eww/target/release/eww
	mkdir -p bin
	cp /tmp/eww/target/release/eww bin/

eww: bin/eww

# ** xfce
xfce:
	sudo ln -s /var/lib/snapd/desktop/applications /usr/share/applications/snapd # FIX snapd packages in menu
