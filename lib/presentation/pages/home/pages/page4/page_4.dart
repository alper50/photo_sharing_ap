
import 'package:flutter/material.dart';
import 'package:greenlive/presentation/widgets/appbar4.dart';

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar4(),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          sliver: SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text("Kullancı Ayarları"),
                  ),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.green,
                          ),
                          title: Text("Hesabım"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: ()=>Navigator.pushNamed(context, 'tomyaccount'),
                        ),
                        BuildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.receipt_long_outlined,
                            color: Colors.green,
                          ),
                          title: Text("Faturalandırma"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: ()=>Navigator.pushNamed(context, 'tobillspage'),
                        ),
                        BuildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.mms_sharp,
                            color: Colors.green,
                          ),
                          title: Text("Paylaşımlarım"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () =>Navigator.pushNamed(context, 'tomypostspage'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text("Uygulama Ayarları"),
                  ),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.notifications,
                            color: Colors.green,
                          ),
                          title: Text("Bildirimler"),
                          onTap: () {},
                        ),
                        BuildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.language,
                            color: Colors.green,
                          ),
                          title: Text("Dil"),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}


