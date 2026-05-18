
extension StringExtension on String {

  String get capitalizeFirst {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  String firstCharacter() {
    final content = trim();
    if (isEmpty) {
      return content;
    }
    return content.substring(0, 1);
  }

  String addCultureCode(String cultureCode) {
    // Chuyển String URL thành Uri để xử lý
    Uri uri = Uri.parse(this);

    // Lấy các query parameters hiện có
    Map<String, String> queryParams = Map<String, String>.from(uri.queryParameters);

    // Thêm hoặc cập nhật culture_code
    queryParams['culture_code'] = cultureCode;

    // Tạo Uri mới với query parameters đã cập nhật
    Uri newUri = uri.replace(queryParameters: queryParams);

    return newUri.toString();
  }

  String toImageUrl() {
    return this;
  }

  List<String> toListString() {
    return split(',').map((e) => e.trim()).toList();
  }

}
