Dockermail - OpenDKIM
===
Once configured and linked to the `email_core`, this image will provide DKIM singing for your mail.

### Configuration
This image looks for key files in an attached settings volume. The configuration will be generated based on the key's filename.

Container will import and process these keys on boot, if you add or change keys - just restart the container for changes to take effect.

#### Generating keys
You will need `opendkim-genkey`, search the web on how to install it on your platform.

Replace `your-domain.tld` with your actual domain and run:
```bash
opendkim-genkey -d your-domain.tld
```
This will produce 2 files:
```
default.txt
default.private
```
Rename `default.private` with your domain like so:
```
[your-domain.tld].opendkim_key
```
For example, if your domain is `awesome-company.co.uk`, then name the key for it `awesome-company.co.uk.opendkim_key`.

Add the resulting file to settings folder, which will be mounted into the image.

##### DNS

You will need to add a DNS record using the info inside `default.txt` file, the instructions for this differ for different domain name providers, below is the basic plan.

Inside the `default.txt` you will find something along these lines:
```
default._domainkey      IN      TXT     ( "v=DKIM1; k=rsa; "
          "p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMBav3q6RhHD9SFsdXJJChkqjYGd7mdggf/0eF1XEq/lnvhk1ArH+cOlwuWki0PLs1xY2sIIPKIyxXEavc1qeygz6sH8RrKPKruywVCOvzzrk68inAZDf+rdMvWKnI5JrnYSgNxPWbDBRQ6+GTj65WbWKWmFS4iMHrJ4SlNbvbSQIDAQAB" )  ; ----- DKIM key default for awesome-company.co.uk
```
Join the text in brackets and remove the quotes, eg:
```
v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMBav3q6RhHD9SFsdXJJChkqjYGd7mdggf/0eF1XEq/lnvhk1ArH+cOlwuWki0PLs1xY2sIIPKIyxXEavc1qeygz6sH8RrKPKruywVCOvzzrk68inAZDf+rdMvWKnI5JrnYSgNxPWbDBRQ6+GTj65WbWKWmFS4iMHrJ4SlNbvbSQIDAQAB
```
Create a TXT record for your domain, use key `default._domainkey` and the long string above as the value.
