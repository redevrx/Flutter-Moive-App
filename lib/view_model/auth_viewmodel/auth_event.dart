import 'package:movie_app/utils/extension.dart';
import '../../models/authentication/login_request.dart';

sealed class BaseAuthEvent {}

class SignInEvent extends BaseAuthEvent {
  final LoginRequest request;
  final OnResult result;
  final OnResult error;

  SignInEvent(
      {required this.request, required this.result, required this.error});
}

class SignOutEvent extends BaseAuthEvent {}

class CreateAccountEvent extends BaseAuthEvent {
  final LoginRequest request;
  final OnResult result;
  final OnResult error;

  CreateAccountEvent({required this.request, required this.result, required this.error});
}

class IsLoginEvent extends BaseAuthEvent {}

class GetUidEvent extends BaseAuthEvent {}

class PasswordVisibleEvent extends BaseAuthEvent {
  final bool visible;

  PasswordVisibleEvent({required this.visible});
}

class CfPasswordVisibleEvent extends BaseAuthEvent {
  final bool visible;

  CfPasswordVisibleEvent({required this.visible});
}

class AcceptEvent extends BaseAuthEvent {
  final bool? accept;

  AcceptEvent({this.accept});
}

class EmailChangeEvent extends BaseAuthEvent {
  final String? value;

  EmailChangeEvent({this.value});
}

class PasswordChangeEvent extends BaseAuthEvent {
  final String? value;

  PasswordChangeEvent({this.value});
}

class CfPasswordChangeEvent extends BaseAuthEvent {
  final String? value;

  CfPasswordChangeEvent({this.value});
}

class ValidateLoginEvent extends BaseAuthEvent {
  final Function() valid;

  ValidateLoginEvent({required this.valid});
}

class ValidateRegisterEvent extends BaseAuthEvent {
  final Function() valid;

  ValidateRegisterEvent({required this.valid});
}

