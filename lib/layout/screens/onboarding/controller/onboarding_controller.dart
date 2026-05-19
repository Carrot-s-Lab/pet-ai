import 'package:image_picker/image_picker.dart';
import 'package:pet_ai_project/layout/common/change_notifier/safe_change_notifier.dart';

class OnboardingController extends SafeChangeNotifier {
  // 0=name, 1=photo, 2=age, 3=sex, 4=breed, 5=conditions, 6=complete
  int _step = 0;
  String _catName = '';
  int _catAgeYears = 1;
  int _catAgeMonths = 0;
  XFile? _catPhoto;
  String _catSex = '';
  String _catBreed = '';
  final List<String> _catConditions = [];

  int get step => _step;
  String get catName => _catName.trim();
  int get catAgeYears => _catAgeYears;
  int get catAgeMonths => _catAgeMonths;
  XFile? get catPhoto => _catPhoto;
  String get catSex => _catSex;
  String get catBreed => _catBreed;
  List<String> get catConditions => List.unmodifiable(_catConditions);

  bool get canContinue => switch (_step) {
        0 => _catName.trim().isNotEmpty,
        1 => _catPhoto != null,
        3 => _catSex.isNotEmpty,
        4 => _catBreed.trim().isNotEmpty,
        5 => _catConditions.isNotEmpty,
        _ => true,
      };

  void updateCatName(String name) {
    _catName = name;
    notifyListeners();
  }

  void updateCatAgeYears(int years) {
    _catAgeYears = years;
    notifyListeners();
  }

  void updateCatAgeMonths(int months) {
    _catAgeMonths = months;
    notifyListeners();
  }

  void updateCatPhoto(XFile? photo) {
    _catPhoto = photo;
    notifyListeners();
  }

  void updateCatSex(String sex) {
    _catSex = sex;
    notifyListeners();
  }

  void updateCatBreed(String breed) {
    _catBreed = breed;
    notifyListeners();
  }

  void toggleCondition(String condition) {
    if (_catConditions.contains(condition)) {
      _catConditions.remove(condition);
    } else {
      _catConditions.add(condition);
    }
    notifyListeners();
  }

  void nextStep() {
    if (_step < 6) {
      _step++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_step > 0) {
      _step--;
      notifyListeners();
    }
  }
}
