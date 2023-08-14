EXCLUDE_FILE='syncignore'
SSH_CMD?="ssh"
MORE_PARMS?=''
RSYNC_OPTS=--exclude-from=$(EXCLUDE_FILE) -e $(SSH_CMD) -zvr
DST=grav@ynh.kouett.net.eu.org:~/user/
SRC=.

sync: rights
	rsync $(RSYNC_OPTS) $(SRC) $(DST)

all: sync

# correct rights on files
rights:
	find . -type f ! -perm 664 -print0 | xargs -r -0 -- chmod -v 644
	find . -type d ! -perm 775 -print0 | xargs -r -0 -- chmod -v 775
