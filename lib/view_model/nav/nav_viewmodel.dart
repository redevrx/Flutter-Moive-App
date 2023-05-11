import 'package:injectable/injectable.dart';
import 'package:movie_app/view_model/base_viewmodel.dart';

@Injectable()
class NavViewModel extends BaseViewModel {
  int _index = 0;
  int get index => _index;

  void onChange(int index) {
    _index = index;
    notifyListeners();
  }

  bool _showSheet = false;
  bool get showSheet => _showSheet;

  void showSheetOption(bool show) {
    _showSheet = show;
    notifyListeners();
  }
}
