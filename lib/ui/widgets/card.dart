import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomCard extends StatelessWidget {
  final String? imgurl;
  final String? title;
  final String? sender;
  final int? category;

  const CustomCard(
      {Key? key, this.imgurl, this.title, this.sender, this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      excludeFromSemantics: false,
      splashColor: Colors.white,
      onTap: () {
        buildShowBottomSheet(context, category);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: category == 0
            ? Colors.blue.withOpacity(0.5)
            : (category == 1
                ? Colors.green.withOpacity(0.5)
                : (category == 2 ? Colors.brown[300]!.withOpacity(0.5) : Colors.grey.withOpacity(0.5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                width: w * 0.88,
                height: w * 0.75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage.memoryNetwork(
                    image: imgurl!,
                    placeholder: kTransparentImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    TextButton(
                      child: Text(sender!),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'touserprofile',
                          arguments: {"nickname": sender},
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title!),
                          Text("konum bilgisi"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PersistentBottomSheetController buildShowBottomSheet(
          BuildContext context, int? category) =>
      showBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            color: category == 0
                ? Colors.blue
                : (category == 1
                    ? Colors.green
                    : (category == 2 ? Colors.brown[300] : Colors.grey)),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage.memoryNetwork(
                          image: imgurl!,
                          placeholder: kTransparentImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(title!),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
