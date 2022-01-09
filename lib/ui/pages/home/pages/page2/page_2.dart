import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/ui/pages/home/pages/page2/bloc/page2_bloc.dart';
import 'package:greenlive/ui/widgets/appbar2.dart';
import 'package:greenlive/ui/widgets/bottom_loader.dart';
import 'package:greenlive/ui/widgets/card2.dart';

// ignore: must_be_immutable
class Page2 extends StatelessWidget {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  Page2Bloc? bloc;

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
                    } as Future<void> Function(),
                    child: BlocBuilder<Page2Bloc, Page2State>(
                      builder: (context, state) {
                        if (state is Page2Initial || state is Page2Loading) {
                          return LoadingWidget();
                        } else if (state is Page2SearchNotFound) {
                          return ErrorWidget(
                              blocc: bloc,
                              text: 'Böyle bir grup bulamadık',
                              isOnlyText: true);
                        } else if (state is Page2Error) {
                          return ErrorWidget(
                              blocc: bloc,
                              text: state.error.toString(),
                              isOnlyText: false);
                        } else if (state is Page2SearchFound) {
                          return _buildSearchResult(state);
                        } else {
                          Page2Fetched fetched = state as Page2Fetched;
                          return _buildGroups(fetched);
                        }
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

  ListView _buildGroups(Page2Fetched fetched) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 15),
        itemCount: fetched.hasreachedmax!
            ? fetched.groups!.length
            : fetched.groups!.length + 1,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          print(fetched.groups);
          if (index < fetched.groups!.length) {
            return Card2(
              isfromnetwork: true,
              groupName: fetched.groups![index].groupName,
              groupTitle: fetched.groups![index].groupTitle,
              imgurl: fetched.groups![index].groupImageUrl,
            );
          } else {
            return BottomLoader();
          }
        });
  }

  ListView _buildSearchResult(Page2SearchFound state) {
    return ListView(
      children: state.groups
          .map((e) => Card2(
                groupName: e.groupName,
                groupTitle: e.groupTitle,
                imgurl: e.groupImageUrl,
              ))
          .toList(),
    );
  }

  void _onScroll() async {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      await Future.delayed(Duration(milliseconds: 500), () {
        bloc!.add(Page2FetchEvent());
      });
    }
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300, child: Center(child: CircularProgressIndicator()));
  }
}

class ErrorWidget extends StatelessWidget {
  final Page2Bloc? blocc;
  final bool? isOnlyText;
  final String? text;
  const ErrorWidget({
    Key? key,
    this.text,
    this.isOnlyText,
    this.blocc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: isOnlyText!
          ? Text(text!)
          : Column(
              children: [
                Text(text!),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    blocc!.add(Page2FetchEvent());
                  },
                  child: Text('Tekrar Dene'),
                ),
              ],
            ),
    );
  }
}
