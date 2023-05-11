import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/moive/moive_data.dart';
import 'package:movie_app/theme/dimens.dart';
import 'package:movie_app/theme/theme.dart';
import 'package:movie_app/theme/widget/animation/translate_animation.dart';
import 'package:movie_app/utils/constant.dart';

class MoiveDetailScreen extends StatelessWidget {
  const MoiveDetailScreen({Key? key, required this.moive}) : super(key: key);

  final MoiveData moive;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top * 1.2,
            ),

            ///title and back icon
            titleCard(context, size),
            const SizedBox(
              height: Dimens.kDefault * 3,
            ),

            ///image content
            imgCard(size),
            const SizedBox(
              height: Dimens.kDefault,
            ),

            ///content
            TranslateAnimation(
              type: 1,
              child: contentCard(size, context),
            ),
            const SizedBox(
              height: Dimens.kDefault,
            ),

            ///moive title
            TranslateAnimation(
                child: Text(
              moive.title ?? "N/A",
              style: Theme.of(context).textTheme.titleLarge,
            )),
            const SizedBox(
              height: Dimens.kDefault,
            ),

            ///moive type
            TranslateAnimation(
              type: 1,
              child: moiveTypeCard(size, context),
            ),
            const SizedBox(
              height: Dimens.kDefault,
            ),

            ///moive plot
            TranslateAnimation(child: plotCard(context))
          ])),
        ),
        bottomNavigationBar: btnBook(size, context),
      ),
    );
  }

  Container plotCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.kDefault),
      alignment: Alignment.center,
      child: Text(
        moive.plot ?? "N/A",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Row moiveTypeCard(Size size, BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.kDefault / 4, vertical: Dimens.kDefault / 4),
          margin: const EdgeInsets.symmetric(
            horizontal: Dimens.kDefault / 2,
          ),
          alignment: Alignment.center,
          width: size.width * .16,
          decoration: BoxDecoration(
              color: kItemColor,
              borderRadius: BorderRadius.circular(Dimens.kDefault / 2)),
          child: Text(
            moive.type ?? "N/A",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.kDefault / 4, vertical: Dimens.kDefault / 4),
          margin: const EdgeInsets.only(
            right: Dimens.kDefault / 2,
          ),
          alignment: Alignment.center,
          width: size.width * .16,
          decoration: BoxDecoration(
              color: kItemColor,
              borderRadius: BorderRadius.circular(Dimens.kDefault / 2)),
          child: Text(
            moive.rated ?? "N/A",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.kDefault / 4, vertical: Dimens.kDefault / 4),
          alignment: Alignment.center,
          width: size.width * .16,
          decoration: BoxDecoration(
              color: kItemColor,
              borderRadius: BorderRadius.circular(Dimens.kDefault / 2)),
          child: Text(
            moive.runtime ?? "N/A",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Row contentCard(Size size, BuildContext context) {
    return Row(
      children: [
        ///imdb
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.kDefault / 4, vertical: Dimens.kDefault / 4),
          margin: const EdgeInsets.symmetric(
            horizontal: Dimens.kDefault / 2,
          ),
          alignment: Alignment.center,
          width: size.width * .18,
          decoration: BoxDecoration(
              color: kItemColor,
              borderRadius: BorderRadius.circular(Dimens.kDefault / 2)),
          child: Text(
            "IMDB :${moive.imdbRating}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.kDefault / 4, vertical: Dimens.kDefault / 4),
          alignment: Alignment.center,
          width: size.width * .28,
          decoration: BoxDecoration(
              color: kItemColor,
              borderRadius: BorderRadius.circular(Dimens.kDefault / 2)),
          child: Text(
            "Rating :${moive.ratings?.last?.value}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Stack imgCard(Size size) {
    return Stack(
      children: [
        Hero(
            tag: '${moive.hashCode}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.kDefault),
              child: CachedNetworkImage(
                  imageUrl:
                      moive.poster != "N/A" ? "${moive.poster}" : kPosterUrl,
                  memCacheWidth: (size.width * 1).toInt(),
                  memCacheHeight: (size.height * .45).toInt()),
            )),
        Positioned(
          right: Dimens.kDefault,
          top: Dimens.kDefault / 5,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(Dimens.kDefault / 2),
              decoration: BoxDecoration(
                  color: kItemColor.withOpacity(.32),
                  borderRadius: BorderRadius.circular(Dimens.kDefault / 2)),
              child: const Icon(
                Icons.favorite_border,
                size: Dimens.kDefault,
                color: kItemColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  Row titleCard(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: Dimens.kSmall + 5),
            width: size.width * .09,
            height: size.height * .038,
            decoration: BoxDecoration(
                color: kItemColor.withOpacity(.33),
                borderRadius: BorderRadius.circular(Dimens.kDefault / 2)),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kItemColor,
              size: Dimens.kDefault * 1.4,
            ),
          ),
        ),
        SizedBox(
          width: size.width * .2,
        ),
        Text(
          "Moive Details",
          style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    );
  }

  GestureDetector btnBook(Size size, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(
            horizontal: Dimens.kDefault * 8, vertical: Dimens.kDefault),
        width: double.infinity,
        height: size.height * .04,
        decoration: BoxDecoration(
            color: kItemColor,
            borderRadius: BorderRadius.circular(Dimens.kDefault * 2)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border,
              size: Dimens.kDefault,
              color: Colors.white,
            ),
            const SizedBox(
              width: Dimens.kSmall,
            ),
            Text(
              "Booking",
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
