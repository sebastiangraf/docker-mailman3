Dockermail - Email Core
==========
This image provides a secure, minimal mail server based on 'postfix' and 'dovecot'.

All incoming mail to your domains is accepted.
For outgoing mail, only authenticated (logged in with username and password) clients can send messages via STARTTLS.

## Setup
You will need 2 folder on your host, one to store your configuration and another one to store your email.
In the instructions below we will use the following:
  * `/opt/dockermail/settings` to store configuration
  * `/opt/dockermail/vmail` to store the mail

The will be mounted into container and store settings and email on host.
All the configuration is done through a `config.json` file, although extra files (eg. SSL keys) will be stored in the settings directory.

There is an example `config.json` file in `config/example` to get you started.

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
* `myhostname` - should be the fully qualified domain of the server hosting email. Although optional you may run into problems with EHLO commands without it.

#### domains
Is an object of account arrays, the key is the domain for which you want to process email, each account has the following keys:
* `email` - email address of the account. Will also be used as the login.
* `password` - password for the account. See example for using plain-text passwords. To get the hash values, you can either install dovecot locally or use `docker exec -it [email_core_container_name] bash` to attach to the running container (step 6) and run `doveadm pw -s <scheme-name>` inside, remember to restart your container if you update the settings!
See [Dovecot Wiki](http://wiki.dovecot.org/Authentication/PasswordSchemes) for more info.
* `aliases` - (Optional) Array of aliases to redirect to this account. For a catch-all use your domain with no account, eg: `@example.com`.

## Build and run

#### Build container
```bash
docker build -t dockermail_email_core .
```
#### Run
To run container add mount points for settings and mail plus SMTP ports 25/587 and IMAP port 143 to host:
```bash
docker run -name dockermail -d -p 25:25 -p 587:587 -p 143:143 -v /opt/dockermail/settings:/mail_settings -v /opt/dockermail/vmail:/vmail dockermail_email_core
```

## Change SSL keys
On boot, a script will copy SSL keys into the settings folder. To use own, replace these keys and restart container.
