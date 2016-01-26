Dockermail - Amavis
===
Once configured and linked to the `email_core`, this image will filter incoming mail for SPAM.
This does not scan email for viruses/malware, only SPAM scoring.

### Configuration

This image will use the same `domains` and `myhostname` configuration as the core, just mount the same settings folder.

See `email_core`'s README for more info.
