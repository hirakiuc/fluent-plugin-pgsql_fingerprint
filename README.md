# fluent-plugin-pgsql_fingerprint

[![wercker status](https://app.wercker.com/status/ab8daa227d0486fc989f5032024b8616/s/master "wercker status")](https://app.wercker.com/project/byKey/ab8daa227d0486fc989f5032024b8616)
[![Code Climate](https://codeclimate.com/github/hirakiuc/fluent-plugin-pgsql_fingerprint/badges/gpa.svg)](https://codeclimate.com/github/hirakiuc/fluent-plugin-pgsql_fingerprint)
[![Test Coverage](https://codeclimate.com/github/hirakiuc/fluent-plugin-pgsql_fingerprint/badges/coverage.svg)](https://codeclimate.com/github/hirakiuc/fluent-plugin-pgsql_fingerprint/coverage)

A Fluent filter plugin to convert **postgres** sql to sql's fingerprint.

## NOTE

This fluent plugin is inspired by [fluent-plugin-sql_fingerprint](https://github.com/kikumoto/fluent-plugin-sql_fingerprint).

Use [fluent-plugin-sql_fingerprint](https://github.com/kikumoto/fluent-plugin-sql_fingerprint) if you want to get sql fingerprint for **mysql** sql.

And this fluent plugin depends on [pg_query gem](https://github.com/lfittl/pg_query) to normalize postgres sql.

## Requirements

Fluentd >= v0.14 (**not latest stable version**)

## Install

```
gem install fluent-plugin-pgsql_fingerprint
```

# Configuration

```
<filter tag.dummy.*>
  type pgsql_fingerprint
</filter>
```

## Sample

A record like this.

```
{
  "sql": "SELECT * FROM demo WHERE record = 'AAA';"
}
```

This fluent plugin filter the record, like this.
(Add `added_key` attribute with normalized sql.)

```
{
  "sql": "SELECT * FROM demo WHERE record = 'AAA';"
  "fingerprint": "SELECT * FROM demo WHERE record = ?;"
}
```

# License

See [LICENSE](https://github.com/hirakiuc/fluent-plugin-pgsql_fingerprint/blob/master/LICENSE).
