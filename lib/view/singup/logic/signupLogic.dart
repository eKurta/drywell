import 'dart:io';

import 'package:drivel/services/photoService/photoService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

/**
 * On signup button pressed creates a user in firebase auth
 */
void onSignUp(
    String username, String email, String password, String confirmPassword,
    [File? image]) async {
  if (username.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty) {
    final user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    if (user != null) {
      try {
        if (image != null) {
          String? photoUrl =
              await PhotoService.uploadPhoto(user.uid + 'USER_PHOTO', image);
          await user.updatePhotoURL(photoUrl);
        }
        await user.updateDisplayName(username);

        await user.sendEmailVerification();
      } catch (e) {
        print('SIGNUP ERROR $e');
      }
    }
  }
}

/**
 * Check if all necesary fields for registration are entered properly
 */
String? hasAllData(
  String username,
  String email,
  String password,
  String confirmPassword,
) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  if (!emailValid) {
    return 'Entered email is invlaid';
  }

  if (password != confirmPassword) {
    return 'Password does not match';
  }

  if (password.length < 6) {
    return 'Password needs to be at least 6 charactes long';
  }

  return null;
}

void resetSignupError(WidgetRef ref) {
  ref.refresh(signupErrorProvider);
}

final signupErrorProvider = StateProvider<String>((ref) => '');
