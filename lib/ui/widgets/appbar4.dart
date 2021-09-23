import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:greenlive/core/config/storage/storage.dart';

class CustomAppBar4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
          expandedHeight: 130,
          pinned: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kullanıcı Ayarları"),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  showDialog(context: context, builder: (context)=>CustomAlertDialog());
                },
              ),
            ],
          ),
          flexibleSpace: PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                width: 100,
                height: 50,
                child: Center(
                  child: Text("Kullanıcı Adı"),
                ),
              ),
            ),
          ),
        );
  }
}

class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1,sigmaY:1),
            child: AlertDialog(
          title: Text("Çıkış Yap"),
          content: Text("Çıkıs yapmak istediğinden emin misin ?"),
          backgroundColor: Colors.green[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              style: OutlinedButton.styleFrom(shape: StadiumBorder()),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text("Vazgeç"),
            ),
            TextButton(
              style: OutlinedButton.styleFrom(shape: StadiumBorder()),
              onPressed: () async {
                bool clear = await Storage.clear();
                if (clear) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("tosignupview", (route) => false);
                }
              },
              child: Text("Çıkış Yap"),
            )
          ],
        ),
      ),
    );
  }
}