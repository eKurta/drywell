import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  static User? user() {
    return FirebaseAuth.instance.currentUser;
  }
}
