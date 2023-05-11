import 'package:flutter/material.dart';
import 'package:movie_app/theme/dimens.dart';
import 'package:movie_app/theme/theme.dart';

class TextEmail extends StatelessWidget {
  const TextEmail({
    super.key,
    required this.size,
    this.error,
    this.onChanged,
  });

  final Size size;
  final String? error;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        alignment: Alignment.center,
        width: size.width * .8,
        height: size.height * .045,
        padding: const EdgeInsets.symmetric(
            vertical: Dimens.kSmall, horizontal: Dimens.kDefault),
        decoration: BoxDecoration(
            color: kDarkItem,
            borderRadius: BorderRadius.circular(Dimens.kCircleDefault / 1.2)),
        child: TextFormField(
          onChanged: onChanged,
          decoration: const InputDecoration(
              icon:
                  Icon(Icons.email, size: Dimens.kDefault, color: Colors.white),
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
    ]);
  }
}
