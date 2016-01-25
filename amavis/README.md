Dockermail - Amavis
===
Once configured and linked to the `email_core`, this image will filter incoming mail for SPAM.
This does not scan email for viruses/malware, only SPAM scoring.

### Configuration

This images only needs to know the domains and will use the same `domains` configuration from `email_core` for easy administration. See `email_core` README for more info.
