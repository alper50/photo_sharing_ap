import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:greenlive/ui/pages/home/pages/page2/bloc/page2_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CustomAppBar2 extends StatelessWidget {
  Page2Bloc _bloc;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<Page2Bloc>(context);
    return SliverAppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            icon: Icon(Icons.group_add_rounded),
            onPressed: () {
              buildShowBottomSheet(context);
            },
          ),
        ),
      ],
      title: Text("Organizasyonlar"),
      centerTitle: true,
      pinned: false,
      floating: false,
      snap: false,
      expandedHeight: 130,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 9.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.96,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromRGBO(244, 243, 243, 1),
                borderRadius: BorderRadius.circular(40)),
            child: TextField(
              maxLines: 1,
              enableSuggestions: false,
              onChanged: (String input) {
                if(input.length>2){
                  _bloc.add(SearchEvent(inputText: _controller.text));
                  print(_bloc.state);
                }
              },
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                hintText: "Search you're looking for",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

PersistentBottomSheetController buildShowBottomSheet(BuildContext context) =>
    showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.green[100],
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
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AutoSizeText(
                        "Tamamen yeni bir organizasyon açmak için tek seferlik 30 tl ücret alınmaktadır. Yinede devam etmek istiyor musunuz?"),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, "tocreategrouppage"),
                      child: Container(
                        height: 36,
                        width: 180,
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
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 36,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                          "İPTAL ET",
                          style: TextStyle(fontSize: 23),
                        )),
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
