import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenlive/ui/pages/authentication/sign_in/sign_in_view.dart';

class SignView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  "DENEMEDENEME",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Text(
                  "DENEMEDENEMEDENEMEDENEME",
                  style: TextStyle(
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: media.width * 0.9,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "tosignupview");
                  },
                  child: Text("Kayıt Ol"),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    primary: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: media.width * 0.9,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    CupertinoPageRoute(builder: (BuildContext context) {
                      return SingInView();
                    });
                    // Navigator.pushNamed(context, "tosigninview");
                  },
                  child: Text("Giriş Yap"),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[500],
                    primary: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
