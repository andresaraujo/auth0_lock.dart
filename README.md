# Auth0 Lock

A Dart Wrapper for [Auth0 Lock](https://auth0.com/docs/libraries/lock)

This package uses `dart:js` to wrap the functionality provided by `auth0-lock.js` in Dart classes.

The `auth0-lock.js` must be included for the wrapper to work:

```html
<!-- Latest major release -->
<script src="http://cdn.auth0.com/js/lock-7.min.js"></script>

<!-- Latest minor release -->
<script src="http://cdn.auth0.com/js/lock-7.x.min.js"></script>

<!-- Latest patch release (recommended for production) -->
<script src="http://cdn.auth0.com/js/lock-7.x.y.min.js"></script>
```

### Notes

The Dart version uses a more idiomatic API, instead of passing callbacks it uses Futures

### Example

See [example](https://github.com/andresaraujo/auth0_lock.dart/blob/master/example/main.dart)