import 'package:image_picker/image_picker.dart';
import 'package:pet_ai_project/layout/common/change_notifier/safe_change_notifier.dart';

class OnboardingController extends SafeChangeNotifier {
  int _step = 0; // 0=welcome, 1=name, 2=age, 3=photo, 4=complete
  String _catName = '';
  int _catAge = 1; // years (index into age list)
  XFile? _catPhoto;

  int get step => _step;
  String get catName => _catName.trim();
  int get catAge => _catAge;
  XFile? get catPhoto => _catPhoto;

  bool get canContinue => _step != 1 || _catName.trim().isNotEmpty;

  void updateCatName(String name) {
    _catName = name;
    notifyListeners();
  }

  void updateCatAge(int ageIndex) {
    _catAge = ageIndex;
    notifyListeners();
  }

  void updateCatPhoto(XFile? photo) {
    _catPhoto = photo;
    notifyListeners();
  }

  void nextStep() {
    if (_step < 4) {
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
