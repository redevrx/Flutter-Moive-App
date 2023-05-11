import 'package:movie_app/models/moive/moive_type.dart';

class SearchOption {
  ///A valid IMDb ID (e.g. tt1285016)
  ///[i]
  final String? i;

  ///Movie title to search for.
  ///[t]
  final String? t;

  ///values => movie, series, episode
  ///Type of result to return.
  ///[type]
  final MoiveType? type;

  ///Year of release.
  ///[y]
  final String? y;

  ///Return short or full plot.
  ///[plot]
  final Plot? plot;

  SearchOption({this.i, this.t, this.type, this.y, this.plot});

  OptionValue? getValue() {
    if (i != null && '$i'.isNotEmpty) {
      return OptionValue(value: "$i", key: "i");
    } else if (t != null && '$t'.isNotEmpty) {
      return OptionValue(value: "$t", key: "t");
    } else if (type != null && '${type?.name}'.isNotEmpty) {
      return OptionValue(value: "${type?.name}", key: "type");
    } else if (y != null && '$y'.isNotEmpty) {
      return OptionValue(value: "$y", key: "y");
    } else if (plot != null && '${plot?.name}'.isNotEmpty) {
      return OptionValue(value: "${plot?.name}", key: "plot");
    }
    return null;
  }

  List<Plot> plotList() => List.of([Plot.short, Plot.full]);
  List<String> yearList() =>
      List.of(["2023", "2022", "2021", "2020", "2019", "2018"]);
  List<MoiveType> moiveTypes() =>
      List.of([MoiveType.episode, MoiveType.movie, MoiveType.series]);
}

class OptionSelector {
  ///default option index 10;
  int? index;
  SearchOption? option;
  OptionSelector({this.index, this.option});
}

class OptionValue {
  String key;
  String value;
  OptionValue({required this.value, required this.key});
}
