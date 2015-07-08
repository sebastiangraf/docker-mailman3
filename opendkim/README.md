Dockermail - OpenDKIM
===
Once configured and linked to the `email_core`, this image will provide DKIM singing for your mail.
Please see http://www.opendkim.org/ for more information on OpenDKIM.

### Configuration
To get going you need to generate a key and set up your domain records (see step 5).

This images uses settings files in an attached volume to configure the container on boot.
You can place these in the same folder as the `email_core`'s settings for easy administration.

  * `opendkim.conf`
  You will find this file in the './config', change `Domain` to your own domain.

  * `mail.private`
  You will need to generate this private key file and use the public key in your domain's DNS setup.

See https://help.ubuntu.com/community/Postfix/DKIM for info on generating keys and setting up your domain.
