Dockermail - OpenDKIM
===
Once configured and linked to the `email_core`, this image will provide DKIM singing for your mail.

### Configuration
To get going you need to generate a key and set up your domain records, see https://help.ubuntu.com/community/Postfix/DKIM for details on doing this.

This image looks for key files in an attached volume to configure domain signing on boot.
Once you generate the private key, rename it with your domain: `[your-domain.tld].opendkim_key` and add it to the mounted settings folder.

For example, if your domain is `awesome-company.co.uk`, then name the key for it `awesome-company.co.uk.opendkim_key`.

Container will import and process these keys on boot, if you add or change keys - just restart the container for changes to take effect.
