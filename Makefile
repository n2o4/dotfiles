DOTFILES := $(shell pwd)
HOSTNAME := $(shell hostname)

# As I'm too lazy to do unified configs to go with multiple boxes, I just
# check against the hostname and copy the correct one over.

all: media x tmux git

media:
	mkdir -p ${HOME}/.mplayer2
	mkdir -p ${HOME}/.ncmpcpp
	ln -fs $(DOTFILES)/rc/rtorrent.rc ${HOME}/.rtorrent.rc
	ln -fs $(DOTFILES)/mplayer2/config ${HOME}/.mplayer2/config
	ln -fs $(DOTFILES)/mplayer2/input.conf ${HOME}/.mplayer2/input.conf
	ln -fs $(DOTFILES)/ncmpcpp/config ${HOME}/.ncmpcpp/config

x:
	mkdir -p ${HOME}/.config/zathura
	ln -fs $(DOTFILES)/rc/zathurarc ${HOME}/.config/zathura/zathurarc
ifeq ('$(HOSTNAME)','luu5')
	ln -fs $(DOTFILES)/rc/Xresources ${HOME}/.Xresources
	ln -fs $(DOTFILES)/rc/xinitrc-luu5 ${HOME}/.xinitrc
else
	ln -fs $(DOTFILES)/rc/Xresources ${HOME}/.Xresources
	ln -fs $(DOTFILES)/rc/xinitrc-slavestate ${HOME}/.xinitrc
endif

tmux:
	mkdir -p ${HOME}/.tmux
	ln -fs $(DOTFILES)/tmux/laptop ${HOME}/.tmux/laptop
	ln -fs $(DOTFILES)/tmux/tmux.conf ${HOME}/.tmux.conf

git:
	ln -fs $(DOTFILES)/git/tigrc ${HOME}/.tigrc
	ln -fs $(DOTFILES)/git/gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES)/git/gitignore_global ${HOME}/.gitignore_global

uninstall:
	rm -r ${HOME}/.ncmpcpp
	rm -r ${HOME}/.mplayer2
	rm ${HOME}/.Xresources
	rm ${HOME}/.xinitrc
	rm ${HOME}/.tmux/laptop
	rm ${HOME}/.tmux.conf
