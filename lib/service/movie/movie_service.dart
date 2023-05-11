import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/models/moive/moive_data.dart';
import 'package:movie_app/models/moive/search_option.dart';
import 'package:movie_app/network/client.dart';
import 'package:movie_app/network/endpoint.dart';

abstract class IMovieService {
  Future<MoiveData> onSearchByTitle(SearchOption option);
  Stream<MoiveData> onSearchByTitleStream(List<SearchOption?> option);
}

@Injectable()
class MoiveService extends IMovieService {
  final _client = GetIt.instance.get<Client>();

  @override
  Future<MoiveData> onSearchByTitle(SearchOption option) async {
    return _client.get(
        url: '$kUrl&t=${option.t}', onSuccess: (it) => MoiveData.fromJson(it));
  }

  @override
  Stream<MoiveData> onSearchByTitleStream(List<SearchOption?> option) {
    var url = kUrl;
    for (var p in option) {
      final value = p?.getValue();
      if (value != null) {
        url += '&${value.key}=${value.value}';
      }
    }
    return _client.getWithStream(
        url: url, onSuccess: (it) => MoiveData.fromJson(it));
  }
}
