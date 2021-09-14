import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:greenlive/presentation/widgets/card2.dart';

class CreateGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            child: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Icon(Icons.chevron_left_rounded, color: Colors.green[900]),
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 30,
                  ),
                  child: AutoSizeText(
                    "Yeni bir grup oluştur",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: AutoSizeText(
                    "Gruplar insanların kendi aralarında yardımlaşmasına ve bağış toplamak için harika yerlerdir",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Card2(
                imgurl: "sgsdgssdgsg",
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.cancel_rounded),
                    onPressed: () {},
                  ),
                  hintText: "Grup Adı",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              AutoSizeText(
                  "Grup oluşturarak hizmet koşullarını kabul etmiş sayılırız"),
              SizedBox(
                height: 10,
              ),
              InkWell(
                splashColor: Colors.black,
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  height: 45,
                  width: double.infinity / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text(
                    "DEVAM ET",
                    style: TextStyle(fontSize: 23),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
