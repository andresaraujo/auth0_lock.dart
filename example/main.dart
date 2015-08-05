import 'dart:html' as dom;
import 'package:auth0_lock/auth0_lock.dart';

void main() {
  var lock = new Auth0Lock(
      '3b2XIdWiDglqpkTaIEqYf2nT3duXeSXW', 'andresaraujo.auth0.com');

  dom.querySelector("#login_popup").onClick.listen((_) {
    lock.show(popupMode: true, options: {'authParams': {'scope': 'openid profile'}}).then(updateProfileName);
  });

  dom.querySelector("#login_redirect").onClick.listen((_) {
    lock.show(options: {'authParams': {'scope': 'openid profile'}});
  });

  dom.querySelector("#logout").onClick.listen((_) {
    dom.window.localStorage.remove('id_token');
    dom.window.location.href = "/";
  });

  var hash = lock.parseHash(dom.window.location.hash);

  if (hash != null && hash['id_token'] != null) {
    //save the token in the session:
    dom.window.localStorage['id_token'] = hash['id_token'];
  }

  if (hash != null && hash['error'] != null) {
    dom.window
    .alert('Therez was an error: ${hash['error']} \n ${hash['error_description']}');
  }

  //retrieve the profile:
  var id_token = dom.window.localStorage['id_token'];
  if (id_token != null) {
    lock.getProfile(id_token).then(updateProfileName).catchError((err) {
      return dom.window
          .alert('There was an error geting the profile: ${err['message']}');
    });
  }
}

updateProfileName(data) {
  var profile = data['profile'] != null ? data['profile'] : data;
  print(profile['name']);
  dom.querySelector("#name").text = profile['name'];
}
