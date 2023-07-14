import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

abstract class TaskService {
  static const String HTTP_GET = "HTTP_GET";
  static const String HTTP_POST = "HTTP_POST";
  static const String HTTP_PUT = "HTTP_PUT";
  static const String HTTP_PATCH = "HTTP_PATCH";
  static const String HTTP_DELETE = "HTTP_DELETE";


  String serverErrorMessage = "";
  String exceptionMessage = "";

  Map<String, String> headers = HashMap<String, String>();

  String token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFlOTczZWUwZTE2ZjdlZWY0ZjkyMWQ1MGRjNjFkNzBiMmVmZWZjMTkiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiV2VzIEVuZGVrZW4iLCJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmlsbWUtZmlsbWUtODk5YjEiLCJhdWQiOiJmaWxtZS1maWxtZS04OTliMSIsImF1dGhfdGltZSI6MTY3OTMzNzE1NSwidXNlcl9pZCI6IlJHYm1SenBJUTBRSFRkZG1LRDFSWmgwYnZ5ODIiLCJzdWIiOiJSR2JtUnpwSVEwUUhUZGRtS0QxUlpoMGJ2eTgyIiwiaWF0IjoxNjc5MzM3MTU1LCJleHAiOjE2NzkzNDA3NTUsImVtYWlsIjoid2VzLmd1aXJyYUBlbmRla2VuLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ3ZXMuZ3VpcnJhQGVuZGVrZW4uY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.ZteMUVmJp38VSQOJUMIDT2nGTMiCkGukT8ZNMxGuVhb5fGf3zwxZrTqxs8tG4nQqKCB-mia_eSn9_42sfoVoQp9EtNr4W2JP5bzTHTJ-kaUUtjO865HSgQMzr8DXONvrH1-yHQnn0cLvWOlHgUyBhcZVTswZWVIjDSC8UZHGi2vrGoAbcB7N0s4aGvISrIY64d042ru4RA63QbyaDdrik2a4f47h9EsBpOLa5vRIGMziGMC6jKPkhWqA8_o6z4Cd2WJmS3_w6POc6HZwfCx-sdIFspbYoYZtPaV5RIVU7dFq8C4l59SoG7gAUwXtnm698ahanc9ZihWSgTbfYQO_ow";

  TaskService() {
    buildAuthorizationHeaders();
  }

  Future buildAuthorizationHeaders() async {
    headers[HttpHeaders.contentTypeHeader] = "application/json";
  }

  Future<http.Response> request(String url, String method,
      {dynamic body, int timeout = 14, bool isFirebaseCall = false}) async {

    http.Response? response;

    try {
      await buildAuthorizationHeaders();

      switch (method) {
        case HTTP_GET:
          response = await http
              .get(Uri.parse(url), headers: headers)
              .timeout(Duration(seconds: timeout));
          break;
        case HTTP_POST:
          response = await http
              .post(Uri.parse(url),
              body: body != null ? json.encode(body) : {},
              headers: headers)
              .timeout(Duration(seconds: timeout));
          break;
      }

      if (response != null) {
        if (response.statusCode == 401) {
          return await request(url, method, body: body);
        }

        if (response.statusCode >= 400 && response.statusCode <= 510) {
          throw Exception(response.body);
        }
      }

      return response!;
    } catch (e) {
      throw Exception(e);
    }
  }
}