import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/theme/theme.dart';
import 'package:movie_app/view_model/base_viewmodel.dart';

@Injectable()
class ThemeViewModel extends BaseViewModel {
  ThemeData _themeData = darkTheme;
  ThemeData get themeData => _themeData;

  void changeTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  @override
  void event<T>({required T event}) {
    // TODO: implement event
  }
}
