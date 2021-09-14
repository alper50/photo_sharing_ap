import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Card2 extends StatelessWidget {
  final imgurl;

  const Card2({Key key, this.imgurl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.memoryNetwork(
              width: MediaQuery.of(context).size.width * 0.93,
              image:
                  imgurl,
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
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
                  'Best Design',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: ()=>Navigator.pushNamed(context, 'togrouppage'),
          ),
        ],
      ),
    );
  }
}
