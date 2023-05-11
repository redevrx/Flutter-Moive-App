import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/models/authentication/login_request.dart';
import 'package:movie_app/utils/log.dart';

abstract class IAuthService {
  Future<String?> onSignIn(LoginRequest request);
  void onSignOut();
  bool isLogin();
  String? getUID();
  Future<bool> onCreateAccount(LoginRequest request);
}

@Injectable()
class AuthService extends IAuthService {
  final _auth = FirebaseAuth.instance;

  @override
  String? getUID() => _auth.currentUser?.uid;

  @override
  bool isLogin() => '${getUID()}'.isNotEmpty && getUID() != null;

  @override
  Future<String?> onSignIn(LoginRequest request) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: request.email, password: request.password);
      return user.user?.uid;
    } catch (err) {
      Log.instance.error("SignIn Error :$err");
      return "";
    }
  }

  @override
  void onSignOut() async {
    await _auth.signOut();
  }

  @override
  Future<bool> onCreateAccount(LoginRequest request) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: request.email, password: request.password);
      return user.user == null ? false : true;
    } catch (err) {
      Log.instance.error("Create Account Error :$err");
      return false;
    }
  }
}
