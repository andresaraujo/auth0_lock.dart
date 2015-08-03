library auth0_lock.util;

import 'dart:js' as js;
import 'dart:convert' show JSON;

dynamic jsify(value) {
  if (value is Map || value is Iterable) {
    return new js.JsObject.jsify(value);
  }
  return value;
}

dynamic dartify(dynamic arg) {
  if (arg is js.JsArray) {
    return arg.toList();
  }
  if (arg is js.JsObject) {
    // TODO(tfortes): Find a better way to convert the js object to a Map.
    // https://code.google.com/p/dart/issues/detail?id=12997
    String json = js.context['JSON'].callMethod('stringify', [arg]);
    return JSON.decode(json);
  }

  return arg;
}