import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class AuthApiProvider {
  Dio dio = Dio();

  Future<bool> signUp(String nick, String mail, String passw,String notifytoken) async {
    var params = {
      "nick": "$nick",
      "email": "$mail",
      "password": "$passw",
      "notifytoken": "$notifytoken",
    };
    String url =
        "https://5631b8a69656.ngrok.io/green_api/api/user/create_user.php";
    try {
      var response = await dio.post(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset = UTF-8",
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
    } on SocketException {
      return false;
    } catch (_) {
      return false;
    }
    return false;
  }
}
