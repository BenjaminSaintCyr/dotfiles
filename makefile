APT=sudo apt install -y
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
