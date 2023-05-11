import 'dart:developer' as dev;

import 'package:movie_app/utils/constant.dart';

class Log {
  Log._();

  static final _instance = Log._();
  static Log get instance => _instance;

  void success(String message) {
    dev.log(message, name: kLogName);
  }

  void error(String error) {
    dev.log(error, name: kLogName);
  }
}
