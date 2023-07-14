import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/api/authentication/authentication_service.dart';
import 'package:todo_list/model/authentication/user-model.dart';
import 'package:todo_list/utils/firebase/firebase_api_keys.dart';

import '../model/authentication/firebase_response_model.dart';
import '../utils/firebase/firebase_exception_utils.dart';

class AuthenticationController extends GetxController {
  final firebaseErrorMessage = "".obs;

  final AuthenticationService _service = AuthenticationService();

  Future<bool> signInUser(String mail, String password) async {
    try {
      FirebaseResponseModel responseModel =
          await _service.signInUser(UserModel(email: mail, password: password));

      await setUserDataToCache(responseModel);

      return true;
    } catch (e) {
      String error =
          FirebaseExceptionUtilsSelection[e.toString().substring(11)]!;

      firebaseErrorMessage(error);

      return false;
    }
  }

  Future<bool> signUpUser(String mail, String password) async {
    try {
      FirebaseResponseModel responseModel =
      await _service.signUpUser(UserModel(email: mail, password: password));

      await setUserDataToCache(responseModel);

      return true;
    } catch (e) {
      String error =
      FirebaseExceptionUtilsSelection[e.toString().substring(11)]!;

      firebaseErrorMessage(error);

      return false;
    }
  }

  Future<void> setUserDataToCache(FirebaseResponseModel responseModel) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        AuthenticationApiKeys.USER_EMAIL, responseModel.email);
    await sharedPreferences.setString(
        AuthenticationApiKeys.LOCAL_ID, responseModel.localId);
  }
}
