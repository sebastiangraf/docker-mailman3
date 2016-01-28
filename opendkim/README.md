Dockermail - OpenDKIM
===
Once configured and linked to the `core`, this image will sign your outgoing mail and help you stay clear of the SPAM folder.

### Configuration
This image looks for key files in an attached settings volume. The configuration will be generated based on the key's filename.

The key should look like this:
```
[your-domain.tld].opendkim_key
```
For example, if your domain is `awesome-company.co.uk`, then name the key for it `awesome-company.co.uk.opendkim_key`.

Container will import and process these keys on boot, if you add or change keys - just restart the container for changes to take effect.

#### Generating keys
A helper script is provided that will generate the key for you.
For example, lets generate a key for domain "awesome-company.co.uk":
```bash
./generate_key.sh awesome-company.co.uk
```
This will output the TXT record you need, and write out a private key file:
```
./generate_key.sh awesome-company.co.uk
Generating keys for awesome-company.co.uk
Add a TXT domain record with key: "default._domainkey" and value:
---------
v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDUUZ5b653JPZ8QqmIr6+NQfIk98yJnP6zBsDqh4jH6kUzUMYE9RMJhfJPiOj6AYeDNC397+cn301UOPyIyx01L7DTlbTd7RTVz4xmZvuXP9G0nUiQqEOuwJ6hWrP9cq9DO0EPSQi4w3b5hE0p7DK6QvqYIOgulehkCFgxAw8hCtQIDAQAB
---------
Printing a private key: awesome-company.co.uk.opendkim_key

```

Add the .opendkim_key file to settings folder, which will be mounted into the image.

Create a TXT record for your domain, use key `default._domainkey` and the long string above as the value.
How this is done will differ for different domain name providers, search the web or ask their support if you get stuck.
