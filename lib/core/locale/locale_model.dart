class LocaleModel {

  final String languageCode;
  final String localeCode;
  final String name;
  final bool isActive;
  final String flag;

  LocaleModel({this.languageCode = '', this.localeCode = '', this.name = '', this.isActive = false, this.flag = ''});

  factory LocaleModel.fromJson(dynamic json) {
    if (json == null) return LocaleModel();
    return LocaleModel(
      languageCode: json['languageCode'] ?? '',
      name: json['name'] ?? '',
      isActive: json['isActive'] ?? false,
      flag: json['flag'] ?? '',
    );
  }

  static LocaleModel get vi {
    return LocaleModel(
      localeCode: 'vi',
      languageCode: 'vi-VN',
      name: 'Tiếng Việt',
      flag: 'https://www.worldometers.info/img/flags/vm-flag.gif',
    );
  }

  static LocaleModel get en {
    return LocaleModel(
      localeCode: 'en',
      languageCode: 'en-US',
      name: 'English',
      flag: 'https://www.worldometers.info/img/flags/us-flag.gif',
    );
  }

  static LocaleModel get ko {
    return LocaleModel(
      localeCode: 'ko',
      languageCode: 'ko-KR',
      name: '한국어',
      flag: 'https://www.worldometers.info/img/flags/ks-flag.gif',
    );
  }

  static LocaleModel get zh {
    return LocaleModel(
      localeCode: 'zh',
      languageCode: 'zh-CN',
      name: '简体中文',
      flag: 'https://www.worldometers.info/img/flags/ch-flag.gif',
    );
  }

  static List<LocaleModel> all = [
    LocaleModel.en,
    LocaleModel.ko,
    LocaleModel.vi,
    LocaleModel.zh,
  ];

}