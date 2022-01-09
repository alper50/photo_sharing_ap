import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:greenlive/core/data/network/post_service.dart';
import 'package:greenlive/ui/widgets/card2.dart';
import 'package:image_picker/image_picker.dart';

String text = '';
XFile? picked;

class CreateGroup extends StatefulWidget {
  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  bool isimageselected = false;
  TextEditingController controller = TextEditingController();
  PostApiProvider api = PostApiProvider();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      text = controller.text;
    });
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
                    vertical: 10,
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
                      imgurl: "${picked!.path}",
                    )
                  : UnselectedCard(),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                child: TextField(
                  controller: controller,
                  onSubmitted: (String text) =>
                      FocusScope.of(context).unfocus(),
                  maxLines: 1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: Colors.green,
                      ),
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
                onTap: () async {
                  setState(() {
                    isloading = true;
                  });
                  var isuploaded=false;
                  if(picked==null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Resim seçilmedi")));
                    setState(() {
                      isloading=false;
                    });
                      
                  }else{
                    if(controller.text==null || controller.text==''){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bir grup ismi belirleyin")));
                    }else{
                      isuploaded = await api.uploadImage(
                      picked!.path, 2, text, 70.111, 70.111);
                      if(!isloading){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Grup oluşturulamadı")));
                      }
                    }
                  }
                  if (isuploaded) {
                    setState(() {
                      isloading = false;
                    });
                  }
                },
                child: Container(
                  height: 45,
                  width: double.infinity / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: !isloading
                      ? Center(
                          child: Text(
                          "DEVAM ET",
                          style: TextStyle(fontSize: 23),
                        ))
                      : Center(child: CircularProgressIndicator(color: Colors.white,)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AutoSizeText(
                  "Grup oluşturarak hizmet koşullarını kabul etmiş sayılırız"),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class UnselectedCard extends StatelessWidget {
  UnselectedCard({Key? key}) : super(key: key);
  XFile? image;
  _getImage() async {
    image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _getImage();
        picked = image;
      },
      child: Stack(
        children: [
          Container(
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
          Container(
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.3,
                0.9
              ], colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2)
              ]),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
