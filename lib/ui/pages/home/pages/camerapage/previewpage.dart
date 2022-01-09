import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenlive/ui/pages/home/pages/uploadimagepage/uploadimagepage.dart';

class CamereVieww extends StatelessWidget {
  final imgPath;

  const CamereVieww({Key? key, this.imgPath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Image.file(
                File(imgPath),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => UploadPage(
                imagepath: imgPath,
              ),
            ),
          );
        },
        child: Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
