import 'package:greenlive/core/data/network/auth_service.dart';


class AuthRepository{
  AuthApiProvider _authApiProvider= AuthApiProvider();

  Future<bool> signUp(String nick, String mail, String passw,String notifytoken){
    return _authApiProvider.signUp(nick, mail, passw, notifytoken);
  }
}