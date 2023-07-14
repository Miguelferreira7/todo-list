import 'package:todo_list/model/authentication/user-model.dart';

import '../../model/authentication/firebase_response_model.dart';
abstract class IAuthenticationService {
  Future<FirebaseResponseModel> signInUser(UserModel userModel);
  Future<FirebaseResponseModel> signUpUser(UserModel userModel);
}