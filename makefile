PM=guix install

all: repos

clean:
	rm -r ~/dotfiles/emacs

system:
	$(PM) git htop tree stow

go: system
	$(PM) go
	go get -v -trimpath -ldflags '-s -w' github.com/golangci/golangci-lint/cmd/golangci-lint
	go get -u -v golang.org/x/tools/cmd/godoc golang.org/x/tools/cmd/goimports golang.org/x/tools/cmd/gorename golang.org/x/tools/cmd/guru github.com/cweill/gotests/... github.com/davidrjenni/reftools/cmd/fillstruct github.com/fatih/gomodifytags github.com/godoctor/godoctor github.com/haya14busa/gopkgs/cmd/gopkgs github.com/josharian/impl github.com/rogpeppe/godef

node: system
	$(PM) node
	npm install eslint
	npm install -g typescript typescript-formatter typescript

python: system
	$(PM) python3 python3-pip

exwm:
	sudo -ln -f ~/dotfiles/.spacemacs.d/layers/exwm/files/exwm.desktop /usr/share/xsession/EXWM.desktop
