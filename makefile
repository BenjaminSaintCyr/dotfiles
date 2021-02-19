PM=guix install

all: emacs

install: emacs system email

clean:
	rm -r ~/dotfiles/emacs

system:
	$(PM) git htop tree stow pandoc screenfetch

golang: system
	$(PM) golang golang-golang-x-tools golint
	go get -v -trimpath -ldflags '-s -w' github.com/golangci/golangci-lint/cmd/golangci-lint
	go get -u -v golang.org/x/tools/cmd/godoc golang.org/x/tools/cmd/goimports golang.org/x/tools/cmd/gorename golang.org/x/tools/cmd/guru github.com/cweill/gotests/... github.com/davidrjenni/reftools/cmd/fillstruct github.com/fatih/gomodifytags github.com/godoctor/godoctor github.com/haya14busa/gopkgs/cmd/gopkgs github.com/josharian/impl github.com/rogpeppe/godef github.com/mdempsky/gocode github.com/zmb3/gogetdoc
  GO111MODULE=on go get -v golang.org/x/tools/gopls@latest
	export PATH=$PATH:$(go env GOPATH)/bin

node: system
	$(PM) node
	npm install eslint
	npm install -g typescript typescript-formatter typescript

python: system
	$(PM) python3 python3-pip

emacs: spacemacs vterm email exwm

spacemacs:
	git clone https://github.com/syl20bnr/spacemacs ~/dotfiles/emacs/.emacs.d
	git clone https://github.com/BenjaminSaintCyr/.spacemacs.d ~/dotfiles/emacs/.spacemacs.d
	git clone https://github.com/timor/spacemacsOS ~/dotfiles/emacs/.spacemacs.d/layers/exwm

vterm: 
	$(PM) cmake libvterm0 libtool-bin

email: emacs
	$(PM) maildir-utils isync
	mkdir ~/Mail
	mbsync -a

exwm: emacs
	sudo ln -f ~/dotfiles/emacs/.spacemacs.d/layers/exwm/files/exwm.desktop /usr/share/xsession/EXWM.desktop
