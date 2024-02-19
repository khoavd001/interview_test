import 'package:interview_test/rsc/string_manager.dart';

enum TypeDrinkEnum {
  popular,
  bestSeller,
  cheap;

  String get getName {
    switch (this) {
      case popular:
        return StringsApp.phoBien;
      case bestSeller:
        return StringsApp.muaNhieu;
      case cheap:
        return StringsApp.giaRe;
      default:
        return StringsApp.phoBien;
    }
  }
}
