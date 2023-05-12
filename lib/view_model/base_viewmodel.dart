import 'package:flutter/foundation.dart';

abstract class BaseViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  void event<T>({required T event});
}
