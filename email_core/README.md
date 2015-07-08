Dockermail - Email Core
==========
This image provides a secure, minimal mail server based on 'postfix' and 'dovecot'.

All incoming mail to your domains is accepted.
For outgoing mail, only authenticated (logged in with username and password) clients can send messages via STARTTLS.

### Setup
You will need 2 folder on your host, one to store your configuration and another one to store your email.
In the instructions below we will use the following:
  * `/opt/dockermail/settings` to store configuration
  * `/opt/dockermail/vmail` to store the mail

Use the the example config files in `config/example` to get you started.

1. Add all domains you want to receive mail for to the file `/opt/dockermail/settings/domains`, like this:

		example.org
		example.net

2. Add user aliases to the file `/opt/dockermail/settings/aliases`:

		johndoe@example.org       john.doe@example.org
		john.doe@example.org      john.doe@example.org
		admin@forum.example.org   forum-admin@example.org
		@example.net              catch-all@example.net

	An IMAP mail account is created for each entry on the right hand side.
	Every mail sent to one of the addresses in the left column will be delivered to the corresponding account in the right column.

3. Add user passwords to the file `/opt/dockermail/settings/passwords` like this

		john.doe@example.org:{PLAIN}password123
		admin@example.org:{SHA256-CRYPT}$5$ojXGqoxOAygN91er$VQD/8dDyCYOaLl2yLJlRFXgl.NSrB3seZGXBRMdZAr6

	To get the hash values, you can either install dovecot locally or use `docker exec -it [email_core_container_name] bash` to attach to the running container (step 6) and run `doveadm pw -s <scheme-name>` inside, remember to restart your container if you update the settings!

4. Change the hostname in file `/opt/dockermail/settings/myhostname` to the correct fully qualified domain of your server.

5. Build container

		docker build -t dockermail_email_core .

6. Run container and map ports 25 and 143 from the host to the container.

	 `docker run -name dockermail -d -p 25:25 -p 587:587 -p 143:143 -v /opt/dockermail/settings:/mail_settings -v /opt/dockermail/vmail:/vmail dockermail_email_core`
