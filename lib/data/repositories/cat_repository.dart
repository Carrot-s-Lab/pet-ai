import '../models/cat.dart';

class CatRepository {
  // TODO: load the current cat from Firestore once the profile flow lands;
  // for now we serve a fixed sample so the prompt pipeline can be tested.
  Future<Cat> getCurrentCat() async => Cat.sample();
}
