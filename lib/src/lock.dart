library auth0_lock.auth0_lock;

import 'dart:js' as js;
import 'dart:async';
import 'util.dart';

class Auth0Lock {
  final js.JsObject _auth0lock;


  /// Create an `Auth0` instance with your [clientID] in Auth0 and your [domain]. Usually <account>.auth0.com
  ///
  /// [options] :
  ///
  ///   - 'cdn' {String}: Use as CDN base url. Defaults to domain if it doesn't equal *.auth0.com.
  ///
  ///   - 'assetsUrl' {String}: Use as assets base url. Defaults to domain if it doesn't equal *.auth0.com.
  ///
  ///   - 'useCordovaSocialPlugins' {boolean}: When Lock is used in a Cordova/Phonegap application,
  ///   it will try authenticating with social connections using a native plugin. The only plugin supported
  ///   is phonegap-facebook-plugin but more will come soon.
  ///
  Auth0Lock(String clientId, String domain,
      {Map<String, Object> options: const {}})
      : _auth0lock = new js.JsObject(
          js.context['Auth0Lock'], [clientId, domain, jsify(options)]) {}

  /// Given the hash (or a query) of an URL returns a dictionary with only relevant
  /// authentication information. If succeeds it will return the following fields:
  /// `profile`, `id_token`, `access_token` and `state`. In case of error, it will
  /// return `error` and `error_description`.
  ///
  Map<String, Object> parseHash(String hash) {
    js.JsObject jobj = _auth0lock.callMethod('parseHash', [hash]);
    return dartify(jobj);
  }

  /// Open the widget on signin mode with signup and reset button actions if enabled for
  /// the configured/default account connection.
  ///
  /// For SPA use [popupMode] = true, otherwise it will use a redirect. [popupMode] defaults to false
  ///
  /// For options specification check: https://auth0.com/docs/libraries/lock/customization
  ///
  /// If the Future resolves as success it will contain the following map:
  /// {'profile': .., 'id_token': .., 'access_token': ..., 'state': ...}
  ///
  Future show({Map<String, Map<String, String>> options : const {}, bool popupMode: false}) {
    var c = new Completer();
    var callback = (error, profile, idToken, accessToken, state, _) {
      return _resolveFuture(c, dartify(error), {
        'profile': dartify(profile),
        'id_token': idToken,
        'access_token': accessToken,
        'state': state
      });
    };

    if(popupMode) {
      _auth0lock.callMethod('show', [jsify(options), callback]);
    } else {
      _auth0lock.callMethod('show', [jsify(options)]);
      c.complete();
    }
    return c.future;
  }

  /// Show widget on `signin` mode with  signup and reset actions disabled by default so no action buttons
  /// are present on widget.
  ///
  /// For SPA use [popupMode] = true, otherwise it will use a redirect. [popupMode] defaults to false
  ///
  /// For options specification check: https://auth0.com/docs/libraries/lock/customization
  ///
  /// If the Future resolves as success it will contain the following map:
  /// {'profile': .., 'id_token': .., 'access_token': ..., 'state': ...}
  ///
  Future showSignin({Map<String, Map<String, String>> options : const {}, bool popupMode: false}) {
    var c = new Completer();
    var callback = (error, profile, idToken, accessToken, state, _) {
      return _resolveFuture(c, dartify(error), {
        'profile': dartify(profile),
        'id_token': idToken,
        'access_token': accessToken,
        'state': state
      });
    };

    if(popupMode) {
      _auth0lock.callMethod('showSignin', [jsify(options), callback]);
    } else {
      _auth0lock.callMethod('showSignin', [jsify(options)]);
      c.complete();
    }
    return c.future;
  }

  /// Show widget on `reset` mode with signup and reset actions disabled by default so no action buttons
  /// are present on widget.
  ///
  /// For SPA use [popupMode] = true, otherwise it will use a redirect. [popupMode] defaults to false
  ///
  /// For options specification check: https://auth0.com/docs/libraries/lock/customization
  ///
  /// If the Future resolves as success it will contain the following map:
  /// {'profile': .., 'id_token': .., 'access_token': ..., 'state': ...}
  ///
  Future showSignup({Map<String, Map<String, String>> options : const {}, bool popupMode: false}) {
    var c = new Completer();
    var callback = (error, profile, idToken, accessToken, state, _) {
      return _resolveFuture(c, dartify(error), {
        'profile': dartify(profile),
        'id_token': idToken,
        'access_token': accessToken,
        'state': state
      });
    };

    if(popupMode) {
      _auth0lock.callMethod('showSignup', [jsify(options), callback]);
    } else {
      _auth0lock.callMethod('showSignup', [jsify(options)]);
      c.complete();
    }

    return c.future;
  }

  /// Show widget on `reset` mode with signup and reset actions disabled by default so no action buttons
  /// are present on widget.
  ///
  /// For SPA use [popupMode] = true, otherwise it will use a redirect. [popupMode] defaults to false
  ///
  /// For options specification check: https://auth0.com/docs/libraries/lock/customization
  ///
  /// If the Future resolves as success it will contain the following map:
  /// {'profile': .., 'id_token': .., 'access_token': ..., 'state': ...}
  ///
  Future showReset({Map<String, Map<String, String>> options : const {}, bool popupMode: false}) {
    var c = new Completer();
    var callback = (error, profile, idToken, accessToken, state, _) {
      return _resolveFuture(c, dartify(error), {
        'profile': dartify(profile),
        'id_token': idToken,
        'access_token': accessToken,
        'state': state
      });
    };

    if(popupMode) {
      _auth0lock.callMethod('showReset', [jsify(options), callback]);
    } else {
      _auth0lock.callMethod('showReset', [jsify(options)]);
      c.complete();
    }
    return c.future;
  }

  /// Hide the widget and call `callback` when done.
  Future hide() {
    var c = new Completer();
    var callback = () {
      return _resolveFuture(c, null, null);
    };

    _auth0lock.callMethod('hide', [callback]);
    return c.future;
  }

  /// Trigger logout redirect with  params from `query` object
  ///
  /// Example:
  ///   auth0.logout({'returnTo': 'http://logout'});
  ///   // redirects to -> 'https://yourapp.auth0.com/logout?returnTo=http://logout'
  ///
  void logout([Map<String, Object> query]) {
    _auth0lock.callMethod('logout', [jsify(query)]);
  }

  /// Get profile data by [token] (`id_token`)
  Future<Map> getProfile(String token) {
    var c = new Completer();
    var callback = (error, profile) => _resolveFuture(c, dartify(error), dartify(profile));

    _auth0lock.callMethod('getProfile', [jsify(token), callback]);
    return c.future;
  }

  /// Resolve a future, given an error and result.
  ///
  void _resolveFuture(Completer c, err, res) {
    if (err != null) {
      c.completeError(err);
    } else {
      c.complete(res);
    }
  }
}
