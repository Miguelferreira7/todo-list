import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../model/authentication/firebase_response_model.dart';
import '../../model/authentication/user-model.dart';
import '../../utils/firebase/firebase_api_keys.dart';
import 'i_authentication_service.dart';

class AuthenticationService implements IAuthenticationService {
  Map<String, String> header = HashMap<String, String>();

  AuthenticationService() {
    header[HttpHeaders.contentTypeHeader] = "application/json";
  }

  @override
  Future<FirebaseResponseModel> signInUser(UserModel userModel) async {
    try {
      final response = await http.post(
        Uri.parse(AuthenticationApiKeys.signInUrl),
        body: jsonEncode(userModel.toJson()),
        headers: header,
      );

      if (response.statusCode >= 400 && response.statusCode <= 510) {
        final firebaseError = jsonDecode(response.body);
        throw Exception(firebaseError['error']['message']);
      }

      return FirebaseResponseModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FirebaseResponseModel> signUpUser(UserModel userModel) async {
    try {
      final response = await http.post(
        Uri.parse(AuthenticationApiKeys.signUpUrl),
        body: jsonEncode(userModel.toJson()),
        headers: header,
      );

      if (response.statusCode >= 400 && response.statusCode <= 505) {
        final firebaseError = jsonDecode(response.body);
        throw Exception(firebaseError['error']['message']);
      }

      return FirebaseResponseModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
