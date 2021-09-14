import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenlive/core/data/network/post_service.dart';

class UploadPage extends StatefulWidget {
  final String imagepath;

  UploadPage({Key key, this.imagepath}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  int _choiceIndex;
  PostApiProvider api = PostApiProvider();
  List<String> _choices = ["Air Pollution", "Water Pollution", "Plastic Warm"];
  TextEditingController controller = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: 275,
                  width: 275,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(widget.imagepath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 9.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.96,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(244, 243, 243, 1),
                              borderRadius: BorderRadius.circular(40)),
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Bir açıklama girin",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      TextButton.icon(
                        icon: Icon(Icons.gps_fixed_sharp),
                        onPressed: () {},
                        label: Text("KOnum Al"),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _choices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChoiceChip(
                        padding: EdgeInsets.all(5),
                        label: Text(_choices[index]),
                        selected: _choiceIndex == index,
                        selectedColor: Colors.green,
                        onSelected: (bool selected) {
                          setState(() {
                            _choiceIndex = selected ? index : 0;
                          });
                        },
                        backgroundColor: _choiceIndex == null
                            ? Colors.blueAccent
                            : (_choiceIndex == 0
                                ? Colors.blue
                                : (_choiceIndex == 1
                                    ? Colors.blueAccent
                                    : Colors.blueAccent)),
                        labelStyle: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (controller.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text("Açıklama kısmı boş olamaz"),
                        ),
                      );
                    } else {
                      if (_choiceIndex == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 3),
                            content: Text("Bir kategori seçilmelidir"),
                          ),
                        );
                      } else {
                        setState(() {
                          isloading = !isloading;
                        });

                        bool response = await api.uploadImage(widget.imagepath,
                            _choiceIndex, controller.text, 25.00, 32.00);
                        print(response);
                        setState(() {
                          isloading = !isloading;
                        });
                        if (response) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              'tohomeview', (Route<dynamic> route) => false);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text("Başarıyla yüklendi"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text("Bir hata oluştu.Tekrar deneyin"),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: isloading == false
                      ? Text(
                          "Paylaş",
                          style: TextStyle(fontSize: 25),
                        )
                      : CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
