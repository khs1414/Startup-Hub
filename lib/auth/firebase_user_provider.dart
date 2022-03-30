import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TheStartUpHubFirebaseUser {
  TheStartUpHubFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

TheStartUpHubFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TheStartUpHubFirebaseUser> theStartUpHubFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<TheStartUpHubFirebaseUser>(
            (user) => currentUser = TheStartUpHubFirebaseUser(user));
