import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/authentication/login_request.dart';
import 'package:movie_app/screen/moive/home/home_screen.dart';
import 'package:movie_app/theme/dimens.dart';
import 'package:movie_app/theme/theme.dart';
import 'package:movie_app/theme/widget/animation/translate_animation.dart';
import 'package:movie_app/theme/widget/dialog/loading_dialog.dart';
import 'package:movie_app/theme/widget/input/text_email.dart';
import 'package:movie_app/theme/widget/input/text_password.dart';
import 'package:movie_app/utils/constant.dart';
import 'package:movie_app/view_model/auth_viewmodel/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TranslateAnimation(
                type: 1,
                child: titleRegister(size, context),
              ),
              registerForm(size, context),

              ///provider listener
            ],
          ),
        ),
      ),
    );
  }

  SizedBox registerForm(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * .6,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///form
            TranslateAnimation(child: Consumer<AuthViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  children: [
                    ///email
                    TextEmail(
                        size: size,
                        onChanged: (it) => viewModel.emailChange(it),
                        error: viewModel.email.error),

                    ///password
                    Consumer<AuthViewModel>(builder: (context, value, child) {
                      return TextPassword(
                          onVisible: () =>
                              value.passwordVisible(!value.visible),
                          size: size,
                          visible: value.visible,
                          onChanged: (it) => viewModel.passwordChange(it),
                          error: viewModel.password.error);
                    }),

                    ///confirm password
                    Consumer<AuthViewModel>(builder: (context, value, child) {
                      return TextPassword(
                          onVisible: () =>
                              value.cfPasswordVisible(!value.cfVisible),
                          size: size,
                          visible: value.cfVisible,
                          onChanged: (it) => viewModel.cfPasswordChange(it),
                          error: viewModel.cfPassword.error);
                    }),
                  ],
                );
              },
            )),

            ///accept
            Consumer<AuthViewModel>(builder: (context, auth, child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: auth.accept,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimens.kSmall * 1.2)),
                          onChanged: (value) => auth.onAccept(value)),
                      Text(
                        "Accept",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  !auth.accept
                      ? Text('Please Click Accept',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: kItemColor))
                      : const SizedBox()
                ],
              );
            }),

            SizedBox(
              height: size.height * .02,
            ),
            TranslateAnimation(
              type: 1,
              child: InkWell(
                splashColor: kItemColor.withOpacity(.23),
                onTap: () {
                  final viewModel = GetIt.instance.get<AuthViewModel>();
                  viewModel.onValidateRegister(() {
                    loadingDialog(context: context);
                    viewModel.onCreateAccount(
                        LoginRequest(
                            email: '${viewModel.email.value}',
                            password: '${viewModel.password.value}'),
                        result: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }, error: () {
                      Navigator.pop(context);
                    });
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .04,
                  decoration: BoxDecoration(
                      color: kItemColor,
                      borderRadius: BorderRadius.circular(Dimens.kDefault),
                      boxShadow: [
                        BoxShadow(
                            color: kItemColor.withOpacity(.23),
                            offset: const Offset(.5, .9),
                            blurRadius: .20,
                            spreadRadius: .1)
                      ]),
                  child: const Text("Register"),
                ),
              ),
            ),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You Have on Account",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: Dimens.kSmall * 2),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("SignIn Now",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: kItemColor)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox titleRegister(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * .4,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .09,
          ),
          CachedNetworkImage(
            imageUrl: kLoginUrl,
            memCacheWidth: (size.width * .5).toInt(),
            memCacheHeight: (size.height * .19).toInt(),
            fit: BoxFit.cover,
          ),
          // title card
          Text(
            'Create Your Account',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
