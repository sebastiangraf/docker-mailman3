Dockermail
==========

A secure, minimal-configuration mail service in docker containers.
This repository is tailored to small private servers, where you own a domain and want to host your own mail.

The setup is modular and so far has:

* `core` -  base SMTP and IMAP server
* `opendkim` - adds DKIM signing service to the core
* `amavis` - adds incoming SPAM filter

Please see the README in each folder for more information on each image.

---
# Config changes
New version has replaced the previous collection of flat files with a single `config.json` file, please see `core` README for details on syntax. You will need to update your configuration to upgrade to new dockermail version.

---

### SPAM
Although OpenDKIM is optional, I highly recommended you use it to help your message across spam filters. See the README in `opendkim` folder for more info on setting it up.

You should also add PTR record to your IP (aka Reverse DNS) which is done by your server provider.
And finally, generate and add an SPF record to your domain, search for instructions on this - there are a few generator site around and the setup steps depend on your domain name provider.

### Compose
Assuming you follow the instructions in the accompanying READMEs to set up both containers, you should just be able to run

```bash
docker-compose up
```

and it will spin up both container and link them together, easy!
See `docker-compose.yml` for details.

### Testing & Development
I have included a `Vagrantfile`, which currently lets you test build the images in a neutral enviroment.
If you have issues building or are making changes to the build, run `vagrant up` to spin up and build images in a VM.

(You will need [Vagrant](https://www.vagrantup.com/) installed for this to work)

### Images on DockerHub
Automated builds of the images are available here:
* Core: https://hub.docker.com/r/adaline/dockermail-core/
* OpenDKIM: https://hub.docker.com/r/adaline/dockermail-opendkim/
* Amavis: https://hub.docker.com/r/adaline/dockermail-amavis/

### Coming soon
* Testing
* Mulit-domain OpenDKIM config
* Easy password generation
