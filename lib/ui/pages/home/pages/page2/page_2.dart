import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/ui/pages/home/pages/page2/bloc/page2_bloc.dart';
import 'package:greenlive/ui/widgets/appbar2.dart';
import 'package:greenlive/ui/widgets/bottom_loader.dart';
import 'package:greenlive/ui/widgets/card2.dart';

class Page2 extends StatelessWidget {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  Page2Bloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<Page2Bloc>(context);
    _scrollController.addListener(() => _onScroll());
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            CustomAppBar2(),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return;
                    },
                    child: BlocBuilder<Page2Bloc, Page2State>(
                      builder: (context, state) {
                        if (state is Page2Initial || state is Loading) {
                          return Container(
                              height: 300,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                        Page2Fetched fetched = state as Page2Fetched;

                        return ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            itemCount: fetched.hasreachedmax
                                ? fetched.mockdata
                                : fetched.mockdata + 1,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, index) {
                              if(index<fetched.mockdata){
                                return Card2(
                                isfromnetwork: true,
                                imgurl:
                                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.ruFm7GSP5c_rNOlCglPVBAHaEY%26pid%3DApi&f=1",
                              );
                              }
                              else{
                                return BottomLoader();
                              }
                            });
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      await Future.delayed(Duration(milliseconds: 500), () {
        bloc.add(Page2FetchEvent());
      });
    }
  }
}
