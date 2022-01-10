import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:greenlive/core/config/storage/storage.dart';

class TokenHelper{
  String? token;
  Future<bool> istokenexist()async{
    bool isfcmtoken = await Storage.getBooleans("fcmtoken");
    return isfcmtoken;
  }
  Future<String?> createToken()async{
    FirebaseMessaging messaging;
    messaging = FirebaseMessaging.instance;
    bool tkn = await istokenexist();
    if(tkn == false){
      messaging.getToken().then((value)async{
        token = value;
        print("TOKEN:"+ value!);
        await Storage.setString("fcmtoken", value);
    });
    }
    return token;
  }
}