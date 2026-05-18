// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:education_app/core/app_config/env/evn_config.dart';
// import 'package:education_app/core/models/token/token_model.dart';
// import 'package:http/http.dart' as http;
//
// class RefreshTokenService {
//
//   late StreamSubscription subscription1;
//
//   final _controller = StreamController<TokenModel?>.broadcast();
//
//   final Duration _maxRefreshTokenTime = const Duration(seconds: 5);
//
//   bool _isRefreshingToken = false;
//
//   String? _refreshToken;
//
//   Stream<TokenModel?> get _stream => _controller.stream;
//
//   void setToken(String? token) {
//     _refreshToken = token;
//   }
//
//   void removeToken() {
//     _refreshToken = null;
//   }
//
//   Future<TokenModel?> execute() async {
//     if (_refreshToken == null) return null;
//     /// call the refresh token method
//     _onRefreshToken();
//
//     /// Create a future that returns null after timeout
//     final timeoutFuture = Future.delayed(_maxRefreshTokenTime, () => null);
//
//     /// Listen for the first token from the stream
//     final newToken = _stream.take(1).first;
//
//     /// Return whichever future completes first: token or timeout
//     final result = await Future.any([newToken, timeoutFuture]);
//
//     print('result: $result');
//
//     return result;
//   }
//
//   Future<void> _onRefreshToken() async {
//     /// If the token is being refreshed, return
//     if (_isRefreshingToken) {
//       return;
//     }
//     /// Set the flag to true to prevent other requests from being processed
//     _isRefreshingToken = true;
//     /// Call the API to refresh the token
//     final tokenModel = await _callApiRefreshToken(refreshToken: _refreshToken);
//     /// Add the new token to the stream
//     _controller.add(tokenModel);
//     /// Reset the flag
//     _isRefreshingToken = false;
//   }
//
//   Future<TokenModel?> _callApiRefreshToken(
//       {required String? refreshToken}) async {
//     log('[REFRESH TOKEN]');
//     final url = Uri.parse(
//         '${EnvConfig.apiUrl()}api/v1/auth/refresh-token');
//     final headers = <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     };
//     final body = jsonEncode({
//       'refresh_token': refreshToken,
//     });
//     try {
//       /// TODO update refresh token
//       print('call api refresh token');
//       final rs = await http.post(url, headers: headers, body: body);
//       final tokenModel =  TokenModel.fromJson(json.decode(rs.body)['data']);
//       return tokenModel;
//     } catch (e) {
//       print('error: $e');
//       return null;
//     }
//   }
// }
