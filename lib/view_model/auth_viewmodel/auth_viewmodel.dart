import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/models/authentication/login_request.dart';
import 'package:movie_app/models/validation/validate_data.dart';
import 'package:movie_app/service/authentication/auth_service.dart';
import 'package:movie_app/utils/extension.dart';
import 'package:movie_app/view_model/base_viewmodel.dart';

@singleton
class AuthViewModel extends BaseViewModel {
  final _authService = GetIt.instance.get<AuthService>();

  ///create account with email-password
  bool _createAccountResult = false;
  bool get createAccountResult => _createAccountResult;

  ///[onCreateAccount]
  ///result value [createAccountResult]
  void onCreateAccount(LoginRequest request,
      {required OnResult result, required OnResult error}) async {
    _createAccountResult = await _authService.onCreateAccount(request);
    if (_createAccountResult) {
      result();
    } else {
      error();
    }
    notifyListeners();
  }

  ///result uuid
  String? _signInResult;
  String get signInResult => "$_signInResult";

  ///[onSignIn]
  void onSignIn(LoginRequest request,
      {required OnResult result, required OnResult error}) async {
    _signInResult = await _authService.onSignIn(request);
    if ('$_signInResult'.isEmpty || _signInResult == null) {
      _password.error = "Password Or Email Invalid";
      error();
    } else {
      result();
    }
    notifyListeners();
  }

  ///[onSignOut]
  void onSignOut() {
    _authService.onSignOut();
  }

  bool _isLogin = false;
  bool get isLoginResult => _isLogin;

  ///[isLogin]
  void isLogin() {
    _isLogin = _authService.isLogin();
    notifyListeners();
  }

  String? _uuid = "";
  String get uuid => "$_uuid";

  ///[getUUID]
  void getUUID() {
    _uuid = _authService.getUID();
    notifyListeners();
  }

  ///visibility
  bool _visible = true;
  bool get visible => _visible;

  ///[passwordVisible]
  void passwordVisible(bool visible) {
    _visible = visible;
    notifyListeners();
  }

  ///confirm visibility
  bool _cfVisible = true;
  bool get cfVisible => _cfVisible;

  ///[passwordVisible]
  void cfPasswordVisible(bool visible) {
    _cfVisible = visible;
    notifyListeners();
  }

  ///checkbox accept
  bool? _accept = true;
  bool get accept => _accept ?? false;

  ///validate accept

  void onAccept(bool? accept) {
    _accept = accept;
    notifyListeners();
  }

  ///validate login screen
  final ValidateData _email = ValidateData();
  ValidateData get email => _email;

  void emailChange(String? value) {
    if ("$value".isValidEmail() == true) {
      _email.value = value;
      _email.error = "";
    } else if ('$value' == "") {
      _email.error = "";
    } else {
      _email.error = "Invalid Email Address.";
    }
    notifyListeners();
  }

  ///validate password
  final ValidateData _password = ValidateData();
  ValidateData get password => _password;

  void passwordChange(String? password) {
    if ('$password'.length > 6) {
      _password.value = password;
      _password.error = "";
    } else if ('$password' == "") {
      _password.error = "";
    } else {
      _password.error = "Password Leg 6 Char";
    }
    notifyListeners();
  }

  void onValidate(Function() valid) {
    if ('${_email.value}' == "") {
      _email.error = "Email Is Empty";
    } else if ('${password.value}' == "") {
      _password.error = "Password Is Empty";
    } else if (_accept == false) {
      _accept = false;
    } else {
      valid();
    }
    notifyListeners();
  }

  ///confirm validate password
  final ValidateData _cfPassword = ValidateData();
  ValidateData get cfPassword => _cfPassword;

  void cfPasswordChange(String? password) {
    if ('$password'.length > 6) {
      _cfPassword.value = password;
      _cfPassword.error = "";
    } else if ('$password' == "") {
      _cfPassword.error = "";
    } else {
      _cfPassword.error = "Password Leg 6 Char";
    }
    notifyListeners();
  }

  void onValidateRegister(Function() valid) {
    if ('${_email.value}' == "") {
      _email.error = "Email Is Empty";
    } else if ('${password.value}' == "") {
      _password.error = "Password Is Empty";
    } else if ('${_cfPassword.value}' == "") {
      _cfPassword.error = "Password Is Empty";
    } else if ('${_cfPassword.value?.trim()}'
            .contains('${password.value?.trim()}') ==
        false) {
      _cfPassword.error = "Password Not Match";
      _password.error = "Password Not Match";
    } else if (_accept == false) {
      _accept = false;
    } else {
      _cfPassword.error = "";
      _password.error = "";
      valid();
    }
    notifyListeners();
  }
}
