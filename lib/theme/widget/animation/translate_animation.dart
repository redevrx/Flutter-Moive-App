import 'package:flutter/cupertino.dart';

class TranslateAnimation extends StatelessWidget {
  const TranslateAnimation({Key? key, required this.child, this.type = 0})
      : super(key: key);

  final Widget child;
  final int type;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeIn,
      builder: (_, value, child) {
        return Transform.translate(
          offset: type == 0 ? Offset(0, 20 * value) : Offset(20 * value, 0),
          child: child,
        );
      },
      child: child,
    );
  }
}
