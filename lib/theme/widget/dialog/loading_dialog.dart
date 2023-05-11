import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app/theme/dimens.dart';
import 'package:movie_app/theme/theme.dart';

Future<void> loadingDialog({required BuildContext context}) {
  return showGeneralDialog(
      barrierLabel: "Select Images",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(animation),
          child: child,
        );
      },
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return WillPopScope(
          child: Material(
            color: Colors.transparent,
            child: Align(
                child: Center(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(Dimens.kDefault * 1.5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey.shade200.withOpacity(0.5)),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kItemColor),
                    ),
                  ),
                ),
              ),
            )),
          ),
          onWillPop: () => Future.value(false),
        );
      });
}
