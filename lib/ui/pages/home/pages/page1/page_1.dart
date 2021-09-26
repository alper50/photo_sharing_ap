import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greenlive/core/data/models/postmodel.dart';
import 'package:greenlive/ui/pages/home/pages/page1/bloc/page1_bloc.dart';
import 'package:greenlive/ui/pages/home/pages/userprofilepage/userprofilepage.dart';
import 'package:greenlive/ui/widgets/appbar1.dart';
import 'package:greenlive/ui/widgets/bottom_loader.dart';
import 'package:greenlive/ui/widgets/card.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  Page1Bloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<Page1Bloc>(context);
    _scrollController.addListener(() => _onScroll());
    return Scaffold(
      backgroundColor: Colors.white70,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          Appbar1(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.maxFinite * 0.9,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: bloc.categories.length,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ChoiceChip(
                          labelStyle: TextStyle(color: Colors.black),
                          selectedColor: Colors.green,
                          backgroundColor: Colors.grey[300],
                          selected: bloc.selectedCategories[index],
                          onSelected: (bool selected) {
                            setState(() {
                              bloc.filterButton(index);
                            });
                            bloc.add(
                                Page1FetchEvent(category: bloc.categories[index]));
                          },
                          label: Text(bloc.categories[index]),
                          elevation: 5,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: RefreshIndicator(
                    backgroundColor: Colors.green,
                    color: Colors.white,
                    onRefresh: () {
                      return;
                    },
                    child: BlocBuilder<Page1Bloc, Page1State>(
                      builder: (context, state) {
                        if (state is Page1Initial) {
                          return Container(
                              height: 300,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.red,
                              )));
                        } else if (state is Page1LoadingData) {
                          return Container(
                              height: 300,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        } else if (state is FetchError) {
                          return Container(
                            height: 300,
                            child: Center(
                              child: Text("Fetch te Bir hata oluştu"),
                            ),
                          );
                        } else if (state is StorageError) {
                          return Container(
                            height: 300,
                            child: Center(
                              child: Text("Storage da Bir hata oluştu"),
                            ),
                          );
                        } else {
                          Fetched fetched = state as Fetched;
                          print("FETCHED REBUİLD");
                          return ListView.builder(
                            itemCount: (fetched.hasreachedmax)
                                ? fetched.posts.length
                                : fetched.posts.length + 1,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, index) {
                              print("MİKTAR --- ${fetched.posts.length}");
                              if (index < fetched.posts.length) {
                                final item = fetched.posts[index];
                                if (item is PostModel) {
                                  return CustomCard(
                                    imgurl: item.imgurl,
                                    sender: item.senderid,
                                    title: item.title,
                                    category: int.parse(item.category),
                                  );
                                } else {
                                  return Container(
                                    height: 100,
                                    child: AdWidget(
                                      ad: item as BannerAd,
                                    ),
                                  );
                                }
                              } else {
                                return BottomLoader();
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      await Future.delayed(Duration(milliseconds: 500), () {
        bloc.add(Page1FetchEvent(category: "deneme"));
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    bloc.close();
    super.dispose();
  }
}
