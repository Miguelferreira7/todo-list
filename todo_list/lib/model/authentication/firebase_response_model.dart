class FirebaseResponseModel {
  final String kind;
  final String email;
  final String idToken;
  final String refreshToken;
  final String expiresIn;
  final String localId;

  FirebaseResponseModel(
      {
        required this.kind,
        required this.email,
        required this.idToken,
        required this.expiresIn,
        required this.localId,
        required this.refreshToken,
        });

  static FirebaseResponseModel fromJson(Map<String, dynamic> json) {
    return FirebaseResponseModel(
      kind: json['kind'] as String,
      email: json['email'] as String,
      idToken: json['idToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: json['expiresIn'] as String,
      localId: json['localId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'idToken': idToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'localId': localId,
    };
  }
}
