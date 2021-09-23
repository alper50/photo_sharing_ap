import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:greenlive/ui/widgets/card2.dart';
import 'package:image_picker/image_picker.dart';

XFile picked;

class CreateGroup extends StatelessWidget {
  bool isimageselected = false;

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
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
              isimageselected
                  ? Card2(
                    isfromnetwork: false,
                      imgurl: "${picked.path}",
                    )
                  : UnselectedCard(),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: TextField(
                  onSubmitted: (String text)=>FocusScope.of(context).unfocus(),
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: UnderlineInputBorder(
                  borderRadius:BorderRadius.circular(10.0),),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel_rounded,color: Colors.green,),
                      onPressed: () {},
                    ),
                    hintText: "Grup Adı",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
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
              SizedBox(
                height: 20,
              ),
              AutoSizeText(
                  "Grup oluşturarak hizmet koşullarını kabul etmiş sayılırız"),
            ],
          ),
        ),
      ),
    );
  }
}

class UnselectedCard extends StatelessWidget {
  UnselectedCard({Key key}) : super(key: key);
  
  _getImage()async{
    XFile image = await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 480,maxWidth: 640);
    picked = image;
  }
// picked imagei yukarıdaki classta card2 ye imgurl olarak paramtere vermeliyiz pathini
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        XFile picked = await _getImage();
      },
      child: Container(
        height: 210,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text("Galeriden resim seçin"),
        ),
      ),
    );
  }
}
