import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 130,
            pinned: true,
            automaticallyImplyLeading: true,
            title: Text("Hesabım"),
            flexibleSpace: PreferredSize(
              preferredSize: Size(double.infinity, 120),
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  width: 200,
                  height: 70,
                  child: Center(
                    child: Text("Kullanıcı Adı"),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height-240,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          tileColor: Colors.green,
                          title: Center(child: Text("Hesap Ayarlarını Değiştir")),
                          onTap: () {},
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          tileColor: Colors.red,
                          title: Center(child: Text("Hesabımı Sil")),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
