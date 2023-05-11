import 'package:flutter/material.dart';
import 'package:movie_app/theme/dimens.dart';
import 'package:movie_app/theme/theme.dart';

class TextPassword extends StatelessWidget {
  const TextPassword({
    super.key,
    required this.size,
    required this.visible,
    this.error,
    this.onChanged,
    this.onVisible,
  });

  final Size size;
  final bool visible;
  final String? error;
  final Function(String)? onChanged;
  final Function()? onVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: size.width * .8,
          height: size.height * .045,
          margin: const EdgeInsets.only(top: Dimens.kDefault),
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.kSmall, horizontal: Dimens.kDefault),
          decoration: BoxDecoration(
              color: kDarkItem,
              borderRadius: BorderRadius.circular(Dimens.kCircleDefault / 1.2)),
          child: TextFormField(
            onChanged: onChanged,
            obscureText: visible,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: onVisible,
                    icon: Icon(
                      !visible ? Icons.visibility : Icons.visibility_off,
                      size: Dimens.kDefault,
                      color: Colors.white,
                    )),
                icon: const Icon(Icons.lock,
                    size: Dimens.kDefault, color: Colors.white),
                border: InputBorder.none,
                focusedBorder: InputBorder.none),
          ),
        ),
        error != null
            ? Text('$error',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: kItemColor))
            : const SizedBox()
      ],
    );
  }
}
