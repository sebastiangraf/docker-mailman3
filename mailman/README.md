# Dockermail - Mailman
===
Mailman extension for `core`.

### Configuration

This image uses the same `config.json` as the `core`.

### Config example

```json
{
  "settings": {
    "myhostname": "mydomain.com",
    "mailman": {
      "secret_key": "enter-a-random-secret-key-here",
      "admin_user": "admin",
      "admin_email": "hostmaster@twines.ch",
      "domains": ["lists.mydomain.com"]
    }
  }
}
```

