all: build

.PHONY: build

build:
	docker build -t dockermail_made_special:2.1.7 .

run:
	docker run -name dockermail -d -p 25:25 -p 587:587 -p 143:143 -v /opt/dockermail/settings:/mail_settings -v /opt/dockermail/vmail:/vmail dockermail_made_special:2.1.7
