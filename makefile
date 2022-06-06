APT=sudo apt install -y
APT-U=sudo apt update -y
TMPDIR := $(shell mktemp -d)

all: emacs

install: debian emacs rice

clean:
	rm -rf ~/.icons/capitaine-cursors ~/.themes/* #~/dotfiles/emacs 

# system

guix: emacs
	stow guix shepherd bash git ssh

debian:
	$(APT) git htop tree stow pandoc screenfetch bashtop cmake libvterm0 libtool-bin

# rice

rice: ~/.icons/capitaine-cursors icons ~/.themes/Orchis

~/.icons/capitaine-cursors:
	$(APT) inkscape x11-apps
	git clone https://github.com/keeferrourke/capitaine-cursors.git $(TMPDIR)/cursor
	cd $(TMPDIR)/cursor && ./build.sh
	mkdir -p ~/.icons/capitaine-cursors
	cp -pr $(TMPDIR)/cursor/dist/dark/* ~/.icons/capitaine-cursors

icons:
	$(APT) numix-icon-theme-circle

~/.themes/Orchis:
	git clone https://github.com/vinceliuice/Orchis-theme.git $(TMPDIR)/theme
	cd $(TMPDIR)/theme && ./install.sh

# emacs

emacs: spacemacs
	stow emacs

spacemacs:
	git clone https://github.com/syl20bnr/spacemacs ~/dotfiles/emacs/.emacs.d
	git clone https://github.com/BenjaminSaintCyr/.spacemacs.d ~/dotfiles/emacs/.spacemacs.d

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

minikube-linux-amd64:
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

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

k8s: minikube-linux-amd64 kvm
	sudo install minikube-linux-amd64 /usr/local/bin/minikube
	minikube start

lttng:
	$(APT) lttng-tools lttng-modules-dkms
