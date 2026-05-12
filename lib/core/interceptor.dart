// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class GlobalHttpClient extends http.BaseClient {
//   final http.Client _inner = http.Client();
//   final MyAppState appState;

//   GlobalHttpClient({required this.appState});

//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) async {
//     if (appState.userToken.isNotEmpty) {
//       request.headers['Authorization'] = 'Bearer ${appState.userToken}';
//     }
//     request.headers['Content-Type'] = 'application/json';
//     request.headers['Accept'] = 'application/json';

//     final streamedResponse = await _inner.send(request);
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode == 401) {
//       debugPrint("Global 401 detected! Logging out...");
//       await appState.logout();
//     }

//     return http.StreamedResponse(
//       Stream.value(response.bodyBytes),
//       response.statusCode,
//       headers: response.headers,
//       reasonPhrase: response.reasonPhrase,
//     );
//   }
// }
