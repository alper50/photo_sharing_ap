import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greenlive/core/data/models/postmodel.dart';
import 'package:greenlive/ui/pages/home/pages/page1/bloc/page1_bloc.dart';
import 'package:greenlive/ui/widgets/appbar1.dart';
import 'package:greenlive/ui/widgets/bottom_loader.dart';
import 'package:greenlive/ui/widgets/card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                _buildCategories(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: BlocBuilder<Page1Bloc, Page1State>(
                    builder: (context, state) {
                      if (state is Page1Initial) {
                        return _buildLoading();
                      } else if (state is Page1LoadingData) {
                        return _buildLoading();
                      } else if (state is FetchError) {
                        return _buildError(context,
                            "${AppLocalizations.of(context).fetcherror} ->${state.e}");
                      } else if (state is StorageError) {
                        return RefreshIndicator(
                          backgroundColor: Colors.green,
                          color: Colors.white,
                          onRefresh: () {
                            return;
                          },
                          child: Stack( //TODO BACKEND GELİNCE REFRESHE BAK
                            children: [
                              _buildError(context,
                                  AppLocalizations.of(context).storagerror),
                            ],
                          ),
                        );
                      } else {
                        Fetched fetched = state as Fetched;
                        return RefreshIndicator(
                          backgroundColor: Colors.green,
                          color: Colors.white,
                          onRefresh: () {
                            print('refreshed');
                            return;
                          },
                          child: ListView.builder(
                            itemCount: (fetched.hasreachedmax)
                                ? fetched.posts.length
                                : fetched.posts.length + 1,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, index) {
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
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildLoading() {
    return Container(
        height: 300,
        child: Center(
            child: CircularProgressIndicator(
          color: Colors.red,
        )));
  }

  Container _buildError(BuildContext context, String error) {
    return Container(
      height: 300,
      child: Center(
        child: Column(
          children: [
            Text(error),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                bloc.add(Page1FetchEvent());
              },
              child: Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCategories() {
    return Container(
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
                bloc.add(Page1FetchEvent(category: bloc.categories[index]));
              },
              label: Text(bloc.categories[index]),
              elevation: 5,
            ),
          );
        },
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
