import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:movie_app/network/base_client.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/network/client_exception.dart';
import 'package:movie_app/utils/log.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class Client extends MoiveClient {
  Future<T> get<T>(
      {required String url,
      required T Function(Map<String, dynamic>) onSuccess}) async {
    Log.instance.success("Starting Request to $url");

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Log.instance.success("Response Data: ${response.body}");
      return onSuccess(json.decode(response.body));
    } else {
      Log.instance.error("code: ${response.statusCode} body: ${response.body}");
      throw MoiveException(
          message: "code: ${response.statusCode} body: ${response.body}");
    }
  }

  Stream<T> getWithStream<T>(
      {required String url,
      required T Function(Map<String, dynamic>) onSuccess}) {
    ///init
    final mController = BehaviorSubject<T>();
    final http.Client client = http.Client();
    final request = http.Request("GET", Uri.parse(url));

    void close() {
      mController.close();
      client.close();
    }

    Log.instance.success("Starting Request to $url");
    client.send(request).then((it) {
      it.stream.listen((res) {
        final data = utf8.decode(res);
        Log.instance.success("Response Data: $data");
        final mJson = json.decode(data);
        if (mJson["Error"] != null) {
          mController
            ..sink
            ..addError(mJson);
        } else {
          mController
            ..sink
            ..add(onSuccess(mJson));
        }
      }, onDone: () {
        close();
      }, onError: (err) {
        Log.instance.error("error :$err}");
        mController
          ..sink
          ..addError(err);
      });
    });

    return mController.stream;
  }
}
