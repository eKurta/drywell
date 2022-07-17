import 'dart:io';

import 'package:drivel/providers/photo/singlePhotoProvider.dart';
import 'package:drivel/utils/buttons/bigDefaultButton.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:drivel/utils/widgets/appBarDefault.dart';
import 'package:drivel/utils/widgets/logo.dart';
import 'package:drivel/utils/widgets/namedTextField.dart';
import 'package:drivel/view/login/pages/loginPage.dart';
import 'package:drivel/view/singup/logic/signupLogic.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class SingUpPage extends ConsumerWidget {
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var error = ref.watch(signupErrorProvider);
    var photo = ref.watch(photoProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            AppBarDefault(
              title: 'Sign up',
              onIconTap: () {
                Navigator.pop(context);
              },
            ),
            verticalSpacing(32),
            Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    ref.read(photoProvider.notifier).state =
                        await _picker.pickImage(source: ImageSource.gallery) ??
                            photo;
                  },
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                        image: photo != null
                            ? DecorationImage(
                                image: Image.file(File(photo.path)).image,
                                fit: BoxFit.fill)
                            : null,
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 2)),
                    child: photo != null ? null : logo(60),
                  ),
                ),
                Positioned(
                  right: 16,
                  child: GestureDetector(
                    onTap: () async {
                      if (ref.watch(photoProvider) == null) {
                        ref.read(photoProvider.notifier).state = await _picker
                            .pickImage(source: ImageSource.gallery);
                      } else {
                        ref.read(photoProvider.notifier).state = null;
                      }
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16)),
                      child: AnimatedRotation(
                        turns: photo != null ? 0.125 : 0,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            verticalSpacing(32),
            NamedTextField(
              name: 'USERNAME',
              controller: _userNameController,
              onTap: () => resetSignupError(ref),
            ),
            NamedTextField(
              name: 'EMAIL',
              controller: _emailController,
              onTap: () => resetSignupError(ref),
            ),
            NamedTextField(
              name: 'PASSWORD',
              obscureText: true,
              controller: _passwordController,
              onTap: () => resetSignupError(ref),
            ),
            NamedTextField(
              name: 'CONFIRM PASSWORD',
              obscureText: true,
              controller: _confirmPasswordController,
              onTap: () => resetSignupError(ref),
            ),
            verticalSpacing(8),
            if (error.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.error_outline_outlined,
                    color: Colors.red,
                    size: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            const Spacer(),
            bigDefaultButton('Sign up', () {
              String? error = hasAllData(
                  _userNameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _confirmPasswordController.text);
              if (error == null) {
                onSignUp(
                    _userNameController.text,
                    _emailController.text,
                    _passwordController.text,
                    _confirmPasswordController.text,
                    File(photo!.path));
              } else {
                ref.read(signupErrorProvider.notifier).state = error;
              }
            }, context),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'ALREADY HAVE AN ACCOUNT?',
                    style: TextStyle(
                        color: Colors.grey.shade600, letterSpacing: -0.3)),
                const TextSpan(text: '  '),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginPage()));
                        resetSignupError(ref);
                      },
                    text: 'SING IN',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87))
              ])),
            )
          ],
        ),
      )),
    );
  }
}
