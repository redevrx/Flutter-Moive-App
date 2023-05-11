import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/screen/authentication/signin_screen.dart';
import 'package:movie_app/theme/dimens.dart';
import 'package:movie_app/theme/theme.dart';
import 'package:movie_app/utils/extension.dart';
import 'package:movie_app/view_model/auth_viewmodel/auth_viewmodel.dart';

class MoiveBottomBar extends StatelessWidget {
  final int index;
  final Callback onTab;
  const MoiveBottomBar({Key? key, this.index = 0, required this.onTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.kDefault),
      height: Dimens.kDefault * 3.5,
      width: double.infinity * .9,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.09),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(Dimens.kDefault),
            topLeft: Radius.circular(Dimens.kDefault)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () => onTab(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.kDefault / 2),
                    child: Icon(
                      Icons.home,
                      color: index == 0 ? kItemColor : Colors.white,
                      size: Dimens.kDefault * 1.8,
                    ),
                  ),
                  index == 0
                      ? const Icon(
                          Icons.circle,
                          color: kItemColor,
                          size: Dimens.kDefault / 1.8,
                        )
                      : const SizedBox()
                ],
              )),
          GestureDetector(
            onTap: () => onTab(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.kDefault / 2),
                  child: Icon(
                    Icons.search,
                    color: index == 1 ? kItemColor : Colors.white,
                    size: Dimens.kDefault * 1.8,
                  ),
                ),
                index == 1
                    ? const Icon(
                        Icons.circle,
                        color: kItemColor,
                        size: Dimens.kDefault / 1.8,
                      )
                    : const SizedBox()
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onTab(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Dimens.kDefault / 2),
                  child: Icon(
                    Icons.auto_graph,
                    color: index == 3 ? kItemColor : Colors.white,
                    size: Dimens.kDefault * 1.8,
                  ),
                ),
                index == 3
                    ? const Icon(
                        Icons.circle,
                        color: kItemColor,
                        size: Dimens.kDefault / 1.8,
                      )
                    : const SizedBox()
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // onTab(4);
              GetIt.instance.get<AuthViewModel>().onSignOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: Dimens.kDefault / 2),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: Dimens.kDefault * 1.8,
                  ),
                ),
                index == 4
                    ? Icon(
                        Icons.circle,
                        color: index == 4 ? kItemColor : Colors.white,
                        size: Dimens.kDefault / 1.8,
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
