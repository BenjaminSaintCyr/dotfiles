APT=sudo apt install -y

all: emacs

install: debian emacs 

clean:
	rm -r ~/dotfiles/emacs

guix: emacs
	stow guix shepherd bash git ssh

debian:
	$(APT) git htop tree stow pandoc screenfetch
	$(APT) cmake libvterm0 libtool-bin

node: system
	$(APT) node
	npm install eslint
	npm install -g typescript typescript-formatter typescript

python: system
	$(APT) python3 python3-pip

emacs: spacemacs
	stow emacs

spacemacs:
	git clone https://github.com/syl20bnr/spacemacs ~/dotfiles/emacs/.emacs.d
	git clone https://github.com/BenjaminSaintCyr/.spacemacs.d ~/dotfiles/emacs/.spacemacs.d

clojure:
	$(APT) clojure leiningen	

clisp:
	$(APT) sbcl slime

lisp-ql: clisp
	curl -o /tmp/ql.lisp http://beta.quicklisp.org/quicklisp.lisp
	sbcl --no-sysinit --no-userinit --load /tmp/ql.lisp \
       --eval '(quicklisp-quickstart:install :path "~/.quicklisp")' \
       --eval '(ql:add-to-init-file)' \
       --quit
