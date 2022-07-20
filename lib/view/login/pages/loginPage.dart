import 'package:drivel/providers/chatProvider.dart/chatProvider.dart';
import 'package:drivel/utils/buttons/bigDefaultButton.dart';
import 'package:drivel/utils/loading.dart';
import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/widgets/logo.dart';
import 'package:drivel/utils/widgets/namedTextField.dart';
import 'package:drivel/view/login/logic/loginLogic.dart';
import 'package:drivel/view/singup/pages/signUpPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var error = ref.watch(signinErrorProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(
                      height: SizeConfig.width,
                      child: Center(child: logo(140))),
                  NamedTextField(
                    name: 'EMAIL',
                    controller: _userNameController,
                    onTap: () => resetSigninError(ref),
                    onSubmitted: (text) => tryLogin(ref, context),
                  ),
                  NamedTextField(
                    name: 'PASSWORD',
                    obscureText: true,
                    controller: _passwordController,
                    onTap: () => resetSigninError(ref),
                    onSubmitted: (text) => tryLogin(ref, context),
                  ),
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
                  bigDefaultButton('Sign in', () async {
                    tryLogin(ref, context);
                  }, context, ref.watch(loadingProvider)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 8),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'DON\'T HAVE AN ACCOUNT?',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              letterSpacing: -0.3)),
                      const TextSpan(text: '  '),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SingUpPage()));
                              resetSigninError(ref);
                            },
                          text: 'SING UP',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87))
                    ])),
                  )
                ],
              ))),
    );
  }

  tryLogin(WidgetRef ref, BuildContext context) async {
    if (!ref.watch(loadingProvider)) {
      ref.read(loadingProvider.notifier).state = true;
      if (!await login(
          _userNameController.text, _passwordController.text, context)) {
        ref.read(signinErrorProvider.notifier).state =
            'Sign in info is incorrect';
        ref.read(loadingProvider.notifier).state = false;
      } else {
        ref.read(loadingProvider.notifier).state = true;
        ref.read(chatsProvider.notifier).getUserChats();
      }
    }
  }
}
