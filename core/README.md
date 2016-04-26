Dockermail - Email Core
==========
This image provides a secure, minimal mail server based on 'postfix' and 'dovecot'.

All incoming mail to your domains is accepted.
For outgoing mail, only authenticated (logged in with username and password) clients can send messages via STARTTLS.

## Setup
You will need 2 folder on your host, one to store your configuration and another one to store your email. For example:
  * `/opt/dockermail/settings`
  * `/opt/dockermail/vmail`

These will be mounted into container and store settings and email on host.

All the configuration is done through a single `config.json` file, extra files (eg. SSL keys) will be stored in the settings directory for backup.
There is an example file in `config/example` to get you started.

#### Remember to restart your container if you update the settings!
---

### config.json
```json
{
  "settings": {
    "myhostname": "mail.example.com"
  },
  "domains": {
    "example.com" :
      [
        {
          "email": "info@example.com",
          "password": "{PLAIN}SuperSecure123",
          "aliases": ["@example.com"]
        },
        {
          "email": "admin@example.com",
          "password": "{SHA256-CRYPT}$5$ojXGqoxOAygN91er$VQD/8dDyCYOaLl2yLJlRFXgl.NSrB3seZGXBRMdZAr6"
        }
      ]
  }
}

```
The hash within *config.json* contains 2 primary keys: `domains` and `settings`.

##### settings
* `myhostname` - should be the fully qualified domain of the server hosting email. Although optional you will have problems with EHLO commands and `amavis` without it.

#### domains
Each domain has an array of account objects, each account has the following keys:
* `email` - email address of the account. Will also be used as the login.
* `password` - password for the account. See below for details.
* `aliases` - (Optional) Array of aliases to redirect to this account. For a catch-all use your domain with no account, eg: `@example.com`.

##### Generating passwords
Passwords have to be in a dovecot format.

A plain-text password looks like this: `{PLAIN}SuperSecure123`.

To get more secure hash values, you need to start the container and run:
```bash
docker exec -it [email_core_container_name] doveadm pw -s [scheme-name]
```
This will attach to a running container, prompt you for a password and provide a hash. For example:
```bash
> docker exec -it dockermail_core_1 doveadm pw -s SHA512-CRYPT
Enter new password:
Retype new password:
{SHA512-CRYPT}$6$OA/BzvLzf7C9uohz$a9B0kCihcHsfnK.x4xJWHs9V7.eR5crVtSUn6hoe6p03oea34.uxkozRUw7RYu13z26xNniY3M1kZu4CgSVaB/
```
See [Dovecot Wiki](http://wiki.dovecot.org/Authentication/PasswordSchemes) for more details on different schemes.

## Run
Using the pre-built image from docker hub, you can start your email by running:
```bash
docker run -name dockermail -d \
-p 25:25 -p 587:587 -p 143:143 -p 993:993 \
-v /opt/dockermail/settings:/mail_settings \
-v /opt/dockermail/vmail:/vmail \
adaline/dockermail-core
```
This will connect SMTP ports 25/587 and IMAP port 143/993 to host and mount the folders as per examples given above.

## SSL
Container will produce own SSL keys and back these up into the settings folder. These files are:
```
ssl-cert-snakeoil.key
ssl-cert-snakeoil.pem
```
On boot it will use these if present. You can replace these backup keys with your own, just restart the container.
