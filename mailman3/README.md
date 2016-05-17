Dockermail - Mailman
===
Mailman extension for `core`.

### Configuration

This image uses the same `config.json` as the `core`.

#### Config example

```json
{
  "settings": {
    "myhostname": "mydomain.com",
    "mailman": {
      "secret_key": "enter-a-random-secret-key-here",
      "language_code": "en-us",
      "time_zone": "America/Chicago",
      "admin_email": "listmaster@mydomain.com",
      "domains": ["lists.mydomain.com"]
    }
  }
}
```

The first domain is used as hostname. The secret key must contain only [A-Za-z0-9].

##### Language Code / Time Zone

supported language codes: http://www.i18nguy.com/unicode/language-identifiers.html

supported time zones: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

#### Config changes

After config changes, mailman and the core container have to be restarted.

### First run

The first run takes some minutes. Check `docker logs` to see the progress.

#### Create superuser

docker exec -it CONTAINER_ID /mailman/bin/mailman-web-django-admin createsuperuser

#### Footer / Welcome Templates

The default templates can be overriden by placing some text files in the templates directory.

* for the template search hierarchy see: https://gitlab.com/mailman/mailman/blob/master/src/mailman/utilities/i18n.py#L53
* for the template substitution placeholders see: https://gitlab.com/mailman/mailman/blob/cd61fcc88245af25bda231710cbbe1eb75a5e0e4/src/mailman/handlers/decorate.py#L234