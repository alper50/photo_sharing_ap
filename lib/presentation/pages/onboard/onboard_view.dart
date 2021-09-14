import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int pageindex = 0;
  List<String> svgpath = ["nature", "map", "card"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Spacer(flex: 1),
            Expanded(
              flex: 5,
              child: buildPageView(),
            ),
            Expanded(
              flex: 2,
              child: buildRowFooter(),
            ),
          ],
        ),
      ),
    );
  }

  PageView buildPageView() {
    return PageView.builder(
        itemCount: 3,
        onPageChanged: (int index) {
          setState(() {
            pageindex = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Expanded(
                flex: 5,
                child: buildSvgPicture("assets/onboard/${svgpath[index]}.svg"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(height: 5,),
                    buildAutoSizeText("Sayfa $index"),
                    SizedBox(height: 5,),
                    buildAutoSizeText("açıklama $index" * 10),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Row buildRowFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircleAvatar(
                  backgroundColor:
                      index == pageindex ? Colors.green : Colors.green[200],
                ),
              ),
            );
          },
        ),
        FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(
            Icons.arrow_right_alt_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "tosignview");
          },
        ),
      ],
    );
  }

  AutoSizeText buildAutoSizeText(String title) {
    return AutoSizeText(
      title,
    );
  }

  SvgPicture buildSvgPicture(String path) => SvgPicture.asset(path);
}
