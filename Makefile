EXCLUDE_FILE='syncignore'
SSH_CMD?="ssh"
MORE_PARMS?=''
RSYNC_OPTS=--exclude-from=$(EXCLUDE_FILE) -e $(SSH_CMD) -zvr
DST_SSH=grav@ynh.kouett.net.eu.org
DST=$(DST_SSH):~/user/
SRC=.
STAGING_SRC=$(SRC)
STAGING_DST=.docker-grav-data/user

# refresh grav plugins
gravplugins:
	$(SSH_CMD) $(DST_SSH) bin/grav install

rsync:
	rsync $(RSYNC_OPTS) $(SRC) $(DST)

# dependency order is important !
sync: clean rights rsync gravplugins
	echo "sync done !"

all: sync

# correct rights on files
rights:
	find . -type f ! -perm 664 -print0 | xargs -r -0 -- chmod -v 644
	find . -type d ! -perm 775 -print0 | xargs -r -0 -- chmod -v 775

clean:
	docker-compose down -v

staging:
	mkdir -p .docker-grav-data
	docker-compose up -d

test: clean staging
	docker-compose run grav bash -c "rm -rvf /var/www/html/user/pages/*"
	sudo rsync $(RSYNC_OPTS) $(STAGING_SRC) $(STAGING_DST)
	docker-compose run grav bash -c "cd /var/www/html && chown -Rv www-data:www-data . && su www-data -s /bin/sh -c './bin/grav install'"
