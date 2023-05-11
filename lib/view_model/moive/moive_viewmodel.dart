import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/models/moive/moive_data.dart';
import 'package:movie_app/models/moive/search_option.dart';
import 'package:movie_app/models/validation/validate_data.dart';
import 'package:movie_app/service/movie/movie_service.dart';
import 'package:movie_app/utils/constant.dart';
import 'package:movie_app/utils/extension.dart';
import 'package:movie_app/view_model/base_viewmodel.dart';

@Injectable()
class MoiveViewModel extends BaseViewModel {
  final _service = GetIt.instance.get<MoiveService>();

  Stream<MoiveData>? _moiveData;
  Stream<MoiveData>? get moiveData => _moiveData;

  void searchByTitle() {
    if (searchText.value != null) {
      final options = [
        _moiveTypeOption.option,
        _plotOption.option,
        _yearOption.option,
        SearchOption(t: _searchText.value)
      ];

      _moiveData = _service.onSearchByTitleStream(options);
      notifyListeners();
    }
  }

  void example() {
    _moiveData = _service.onSearchByTitleStream([SearchOption(t: "gundam")]);
    notifyListeners();
  }

  ///search box
  final ValidateData _searchText = ValidateData();
  ValidateData get searchText => _searchText;

  void searchTextChange(String? text) {
    _searchText.value = text;
    _searchText.error = "";
    notifyListeners();
  }

  void validateSearch(OnValid valid) {
    if ('${_searchText.value}'.isEmpty || _searchText.value == null) {
      _searchText.error = "Please Enter Moive Title..";
    } else {
      valid();
    }
    notifyListeners();
  }

  ///search option data list
  final option = SearchOption();

  ///moive type option
  final OptionSelector _moiveTypeOption = OptionSelector();
  OptionSelector get moiveTypeOption => _moiveTypeOption;

  ///[selectMoiveType]
  void selectMoiveType({required int index}) {
    if (index == kOptionIndex) {
      _moiveTypeOption.index = index;
      _moiveTypeOption.option = SearchOption();
    } else {
      _moiveTypeOption.index = index;
      _moiveTypeOption.option = SearchOption(type: option.moiveTypes()[index]);
    }
    notifyListeners();
  }

  ///moive plot option
  final OptionSelector _plotOption = OptionSelector(index: kOptionIndex);
  OptionSelector get plotOption => _plotOption;

  ///[selectPlot]
  void selectPlot({required int index}) {
    if (index == kOptionIndex) {
      _plotOption.index = index;
      _plotOption.option = SearchOption();
    } else {
      _plotOption.index = index;
      _plotOption.option = SearchOption(plot: option.plotList()[index]);
    }
    notifyListeners();
  }

  final OptionSelector _yearOption = OptionSelector(index: kOptionIndex);
  OptionSelector get yearOption => _yearOption;

  void selectYear({required int index}) {
    if (index == kOptionIndex) {
      _yearOption.index = index;
      _yearOption.option = SearchOption();
    } else {
      _yearOption.index = index;
      _yearOption.option = SearchOption(y: option.yearList()[index]);
    }
    notifyListeners();
  }
}
