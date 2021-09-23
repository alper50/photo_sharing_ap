import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class GroupPageAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 65,
      expandedHeight: 200,
      pinned: true,
      floating: false,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.all(7),
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon(Icons.chevron_left_rounded),
          ),
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon(Icons.format_align_right_rounded),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text(
          "Grup 1",
          style: TextStyle(color: Colors.white70),
        ),
        background: FadeInImage.memoryNetwork(
          width: MediaQuery.of(context).size.width * 0.93,
          image:
              "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.ruFm7GSP5c_rNOlCglPVBAHaEY%26pid%3DApi&f=1",
          placeholder: kTransparentImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
