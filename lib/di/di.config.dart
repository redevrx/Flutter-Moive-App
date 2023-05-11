// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:movie_app/network/client.dart';
import 'package:movie_app/service/authentication/auth_service.dart';
import 'package:movie_app/service/movie/movie_service.dart';
import 'package:movie_app/view_model/auth_viewmodel/auth_viewmodel.dart';
import 'package:movie_app/view_model/moive/moive_viewmodel.dart';
import 'package:movie_app/view_model/nav/nav_viewmodel.dart';
import 'package:movie_app/view_model/theme/theme_viewmodel.dart';

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory(() => ThemeViewModel());
    gh.singleton(Client());
    gh.factory(() => AuthService());
    gh.singleton(AuthViewModel());
    gh.factory(() => MoiveService());
    gh.factory(() => MoiveViewModel());
    gh.factory(() => NavViewModel());
    // gh.singleton<_i5.Client>(_i5.Client());
    // gh.factory<_i6.MoiveService>(() => _i6.MoiveService());
    return this;
  }
}
