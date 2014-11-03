all: dovecot

.PHONY: dovecot

dovecot:
	cd dovecot; docker build -t dovecot_made_special:2.1.7 .

run-dovecot:
	docker run -d -p 25:25 -p 587:587 -p 143:143 -v /opt/dockermail/settings:/mail_settings -v /opt/dockermail/vmail:/vmail dovecot_made_special:2.1.7

run-all: run-dovecot
