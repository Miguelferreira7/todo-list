class AuthenticationApiKeys {
  static const String TOKEN_ID = "TOKEN_ID";
  static const String REFRESH_TOKEN = "REFRESH_TOKEN";
  static const String TOKEN_EXPIRES_IN = "TOKEN_EXPIRES_IN";
  static const String USER_EMAIL = "USER_EMAIL";
  static const String USER_ID = "USER_ID";
  static const String LOCAL_ID = "LOCAL_ID";

  static const String _apiKey = "AIzaSyDRsVh02rLE3GXpLX0WzNVs5WX8Yd-qGpE";

  static const String signUpUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey";
  static const String signInUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey";
  static const String resetPasswordUrl = "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey";
  static const String refreshTokenUrl = "https://securetoken.googleapis.com/v1/token?key=$_apiKey";
}