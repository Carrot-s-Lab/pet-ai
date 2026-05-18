//
// import '../../../generated/l10n.dart';
//
// class AppValidator {
//
//   static String _emptyFieldContent({String? field}) {
//     if (field == null) return Tr.current.emptyInformation;
//     return Tr.current.emptyField.replaceAll('@field@', field);
//   }
//
//   // static String? phone(String? phone) {
//   //   if (!hasValue(value: phone)) return _emptyFieldContent(field: 'phone_number');
//   //   final rs =
//   //       RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$")
//   //           .hasMatch(phone!);
//   //   return rs ? null : 'invalid_phone_number';
//   // }
//
//   static String? email(String? email) {
//     if (hasValue(value: email) != null) return _emptyFieldContent(field: Tr.current.email);
//     var rs = RegExp(
//         r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//         .hasMatch(email!);
//     return rs ? null : Tr.current.invalidEmail;
//   }
//
//   static String? username(String? username) {
//     if (hasValue(value: username) != null) return _emptyFieldContent(field: 'username');
//     var rs = RegExp(
//         r'^[a-zA-Z0-9_]+$')
//         .hasMatch(username!);
//     return rs ? null : 'invalid_username';
//   }
//
//   static String? hasValue({required String? value, String? fieldName}) {
//     return (value == null || value.isEmpty)
//         ? Tr.current.emptyField.replaceAll('@field@', fieldName ?? Tr.current.information)
//         : null;
//   }
// }
