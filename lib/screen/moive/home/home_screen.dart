import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/moive/moive_data.dart';
import 'package:movie_app/screen/moive/detail/moive_detail_screen.dart';
import 'package:movie_app/theme/dimens.dart';
import 'package:movie_app/theme/theme.dart';
import 'package:movie_app/theme/widget/animation/translate_animation.dart';
import 'package:movie_app/theme/widget/nav/moive_nav.dart';
import 'package:movie_app/utils/constant.dart';
import 'package:movie_app/view_model/moive/moive_viewmodel.dart';
import 'package:movie_app/view_model/nav/nav_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    exampleMoive();
    super.initState();
  }

  void exampleMoive() {
    Future.delayed(const Duration(milliseconds: 200), () {
      Provider.of<MoiveViewModel>(context, listen: false).example();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.kDefault),
              child: Center(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ///
                        TranslateAnimation(
                          type: 1,
                          child: titleMoive(size, context),
                        ),

                        ///
                        TranslateAnimation(child: contentCard(size, context))
                      ],
                    ),

                    ///bottom sheet search option
                    sheetSearchOption(size),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: mainNav(),
        ),
        onWillPop: () => Future.value(false));
  }

  Consumer<NavViewModel> sheetSearchOption(Size size) {
    return Consumer<NavViewModel>(
      builder: (context, value, child) {
        if (value.showSheet) {
          return Positioned.fill(
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              maxChildSize: .8,
              minChildSize: 0.1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Material(
                  child: Container(
                    padding: const EdgeInsets.all(Dimens.kDefault),
                    decoration: BoxDecoration(
                        color: Colors.white10.withOpacity(.09),
                        borderRadius: BorderRadius.circular(Dimens.kDefault)),
                    margin: const EdgeInsets.symmetric(
                        horizontal: Dimens.kDefault / 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///title and back icon
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  value.showSheetOption(!value.showSheet);
                                },
                                child: Container(
                                  width: size.width * .1,
                                  height: size.height * .032,
                                  decoration: BoxDecoration(
                                      color: kItemColor.withOpacity(.23),
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.arrow_back_ios_sharp,
                                    color: kItemColor,
                                    size: Dimens.kDefault * 1.1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .04,
                              ),
                              Text(
                                "Search & Filter",
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),

                          ///
                          const SizedBox(height: Dimens.kSmall * 5),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: Dimens.kSmall + 4),
                            child: Text(
                              "Moive Type",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),

                          ///moive type option
                          Consumer<MoiveViewModel>(
                              builder: (context, value, child) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * .04,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: Provider.of<MoiveViewModel>(context,
                                            listen: false)
                                        .option
                                        .moiveTypes()
                                        .length +
                                    1,
                                itemBuilder: (context, index) {
                                  final data = Provider.of<MoiveViewModel>(
                                          context,
                                          listen: false)
                                      .option
                                      .moiveTypes();
                                  return index == 3
                                      ? InkWell(
                                          onTap: () => value.selectMoiveType(
                                              index: kOptionIndex),
                                          child: Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: Dimens.kSmall,
                                                      vertical:
                                                          Dimens.kDefault / 6),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .08,
                                              decoration: BoxDecoration(
                                                  color: kItemColor
                                                      .withOpacity(.33),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimens.kDefault /
                                                              2.5)),
                                              child: const Icon(
                                                Icons.cancel_outlined,
                                                size: Dimens.kDefault,
                                                color: kItemColor,
                                              )),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            value.selectMoiveType(index: index);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: Dimens.kDefault / 8,
                                                vertical: Dimens.kDefault / 6),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .14,
                                            decoration: BoxDecoration(
                                                color: value.moiveTypeOption
                                                            .index ==
                                                        index
                                                    ? kItemColor
                                                        .withOpacity(.33)
                                                    : kItemColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimens.kDefault / 2.5)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(data[index].name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium),
                                              ],
                                            ),
                                          ),
                                        );
                                },
                              ),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: Dimens.kSmall + 4, top: Dimens.kDefault),
                            child: Text(
                              "Moive Plot",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),

                          ///plot moive option
                          Consumer<MoiveViewModel>(
                              builder: (context, value, child) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * .04,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: Provider.of<MoiveViewModel>(context,
                                            listen: false)
                                        .option
                                        .plotList()
                                        .length +
                                    1,
                                itemBuilder: (context, index) {
                                  final data = Provider.of<MoiveViewModel>(
                                          context,
                                          listen: false)
                                      .option
                                      .plotList();
                                  return index == 2
                                      ? InkWell(
                                          onTap: () => value.selectPlot(
                                              index: kOptionIndex),
                                          child: Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: Dimens.kSmall,
                                                      vertical:
                                                          Dimens.kDefault / 6),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .08,
                                              decoration: BoxDecoration(
                                                  color: kItemColor
                                                      .withOpacity(.33),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimens.kDefault /
                                                              2.5)),
                                              child: const Icon(
                                                Icons.cancel_outlined,
                                                size: Dimens.kDefault,
                                                color: kItemColor,
                                              )),
                                        )
                                      : InkWell(
                                          onTap: () =>
                                              value.selectPlot(index: index),
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: Dimens.kDefault / 8,
                                                vertical: Dimens.kDefault / 6),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .14,
                                            decoration: BoxDecoration(
                                                color: value.plotOption.index ==
                                                        index
                                                    ? kItemColor
                                                        .withOpacity(.33)
                                                    : kItemColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimens.kDefault / 2.5)),
                                            child: Text(data[index].name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                          ),
                                        );
                                },
                              ),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: Dimens.kSmall + 4, top: Dimens.kDefault),
                            child: Text(
                              "Release Year",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),

                          ///Release year moive
                          Consumer<MoiveViewModel>(
                              builder: (context, value, child) {
                            return Wrap(children: [
                              InkWell(
                                onTap: () => value.selectYear(index: 0),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Dimens.kDefault / 8,
                                      vertical: Dimens.kDefault / 6),
                                  width:
                                      MediaQuery.of(context).size.width * .14,
                                  decoration: BoxDecoration(
                                      color: value.yearOption.index == 0
                                          ? kItemColor.withOpacity(.33)
                                          : kItemColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimens.kDefault / 2.5)),
                                  child: Text(value.option.yearList()[0],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ),
                              InkWell(
                                onTap: () => value.selectYear(index: 1),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Dimens.kDefault / 8,
                                      vertical: Dimens.kDefault / 6),
                                  width:
                                      MediaQuery.of(context).size.width * .14,
                                  decoration: BoxDecoration(
                                      color: value.yearOption.index == 1
                                          ? kItemColor.withOpacity(.33)
                                          : kItemColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimens.kDefault / 2.5)),
                                  child: Text(value.option.yearList()[1],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ),
                              InkWell(
                                onTap: () => value.selectYear(index: 2),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Dimens.kDefault / 8,
                                      vertical: Dimens.kDefault / 6),
                                  width:
                                      MediaQuery.of(context).size.width * .14,
                                  decoration: BoxDecoration(
                                      color: value.yearOption.index == 2
                                          ? kItemColor.withOpacity(.33)
                                          : kItemColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimens.kDefault / 2.5)),
                                  child: Text(value.option.yearList()[2],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ),
                              InkWell(
                                onTap: () => value.selectYear(index: 3),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Dimens.kDefault / 8,
                                      vertical: Dimens.kDefault / 6),
                                  width:
                                      MediaQuery.of(context).size.width * .14,
                                  decoration: BoxDecoration(
                                      color: value.yearOption.index == 3
                                          ? kItemColor.withOpacity(.33)
                                          : kItemColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimens.kDefault / 2.5)),
                                  child: Text(value.option.yearList()[3],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ),
                              InkWell(
                                onTap: () => value.selectYear(index: 4),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Dimens.kDefault / 8,
                                      vertical: Dimens.kDefault / 6),
                                  width:
                                      MediaQuery.of(context).size.width * .14,
                                  decoration: BoxDecoration(
                                      color: value.yearOption.index == 4
                                          ? kItemColor.withOpacity(.33)
                                          : kItemColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimens.kDefault / 2.5)),
                                  child: Text(value.option.yearList()[4],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ),
                              InkWell(
                                onTap: () => value.selectYear(index: 5),
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: Dimens.kDefault / 8,
                                      vertical: Dimens.kDefault / 6),
                                  width:
                                      MediaQuery.of(context).size.width * .14,
                                  decoration: BoxDecoration(
                                      color: value.yearOption.index == 5
                                          ? kItemColor.withOpacity(.33)
                                          : kItemColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimens.kDefault / 2.5)),
                                  child: Text(value.option.yearList()[5],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              ),
                              InkWell(
                                onTap: () =>
                                    value.selectYear(index: kOptionIndex),
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: Dimens.kSmall,
                                        vertical: Dimens.kDefault / 4),
                                    width:
                                        MediaQuery.of(context).size.width * .06,
                                    decoration: BoxDecoration(
                                        color: kItemColor.withOpacity(.33),
                                        borderRadius: BorderRadius.circular(
                                            Dimens.kDefault / 2.5)),
                                    child: const Icon(
                                      Icons.cancel_outlined,
                                      size: Dimens.kDefault,
                                      color: kItemColor,
                                    )),
                              )
                            ]);
                          }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Consumer<NavViewModel> mainNav() {
    return Consumer<NavViewModel>(
      builder: (context, viewModel, child) => MoiveBottomBar(
          index: viewModel.index, onTab: (index) => viewModel.onChange(index)),
    );
  }

  SizedBox contentCard(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * .6,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Found Moive",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(
              height: size.height * .04,
            ),

            ///content from api
            Consumer<MoiveViewModel>(
              builder: (context, moive, child) {
                return StreamBuilder<MoiveData>(
                    stream: moive.moiveData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MoiveDetailScreen(
                                          moive: snapshot.data!,
                                        )));
                          },
                          child: Stack(
                            children: [
                              Hero(
                                  tag: '${snapshot.data.hashCode}',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimens.kDefault * 2),
                                    child: CachedNetworkImage(
                                        imageUrl: snapshot.data?.poster != "N/A"
                                            ? "${snapshot.data?.poster}"
                                            : kPosterUrl,
                                        memCacheWidth:
                                            (size.width * .86).toInt(),
                                        memCacheHeight:
                                            (size.height * .45).toInt(),
                                        fit: BoxFit.contain),
                                  )),

                              /// title name
                              Positioned.fill(
                                bottom: Dimens.kDefault * 2,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text("${snapshot.data?.title}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                      textAlign: TextAlign.center),
                                ),
                              ),

                              ///imdb card
                              Positioned.fill(
                                bottom: size.height * .3,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimens.kDefault),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Dimens.kDefault / 8,
                                              horizontal: Dimens.kDefault / 2),
                                          decoration: BoxDecoration(
                                              color: kItemColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimens.kDefault / 2)),
                                          child: Text(
                                            '${snapshot.data?.ratings?.length}' ==
                                                    "0"
                                                ? "N/A"
                                                : 'Rating ${snapshot.data?.ratings?.last?.value}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: Dimens.kSmall,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: Dimens.kDefault / 8,
                                              horizontal: Dimens.kDefault / 2),
                                          decoration: BoxDecoration(
                                              color: kItemColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimens.kDefault / 2)),
                                          child: Text(
                                            "IMDB ${snapshot.data?.imdbRating}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              /// favorite
                              Positioned.fill(
                                top: Dimens.kDefault * 1.2,
                                right: Dimens.kDefault,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                          Dimens.kDefault / 2),
                                      decoration: BoxDecoration(
                                          color: kItemColor.withOpacity(.18),
                                          borderRadius: BorderRadius.circular(
                                              Dimens.kDefault / 2)),
                                      child: const Icon(
                                        Icons.favorite_border,
                                        size: Dimens.kDefault,
                                        color: kItemColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Dimens.kDefault * 2),
                          child: Image.asset("assets/error_page_cat.png",
                              cacheWidth: (size.width * .8).toInt(),
                              cacheHeight: (size.height * .4).toInt(),
                              fit: BoxFit.contain),
                        );
                      } else {
                        return const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kItemColor));
                      }
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  SizedBox titleMoive(Size size, BuildContext context) {
    return SizedBox(
        height: size.height * .3,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top * 2),
            Text("Moive App", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(
              height: size.height * .04,
            ),

            ///search
            Consumer<MoiveViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.kDefault),
                          width: size.width * .77,
                          height: size.height * .05,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.09),
                            borderRadius:
                                BorderRadius.circular(Dimens.kDefault / 1.2),
                          ),
                          child: TextFormField(
                            onChanged: (value) =>
                                viewModel.searchTextChange(value),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {
                              viewModel.validateSearch(() {
                                viewModel.searchByTitle();
                              });
                            },
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      viewModel.validateSearch(() {
                                        viewModel.searchByTitle();
                                      });
                                    },
                                    icon: const Icon(Icons.search,
                                        color: kItemColor)),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintStyle:
                                    Theme.of(context).textTheme.titleSmall,
                                hintText: "Search a Moive"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final navViewModel = Provider.of<NavViewModel>(
                                context,
                                listen: false);
                            navViewModel
                                .showSheetOption(!navViewModel.showSheet);
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: Dimens.kSmall + 5),
                            width: size.width * .11,
                            height: size.height * .045,
                            decoration: BoxDecoration(
                                color: kItemColor.withOpacity(.13),
                                borderRadius:
                                    BorderRadius.circular(Dimens.kDefault / 2)),
                            child: const Icon(
                              Icons.filter_list_outlined,
                              color: kItemColor,
                              size: Dimens.kDefault * 1.4,
                            ),
                          ),
                        )
                      ],
                    ),
                    viewModel.searchText.error != null
                        ? Text(
                            '${viewModel.searchText.error}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: kItemColor),
                          )
                        : const SizedBox()
                  ],
                );
              },
            ),
          ],
        ));
  }
}
