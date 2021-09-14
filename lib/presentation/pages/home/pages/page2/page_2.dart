import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/presentation/pages/home/pages/page2/bloc/page2_bloc.dart';
import 'package:greenlive/presentation/widgets/appbar2.dart';
import 'package:greenlive/presentation/widgets/card2.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Page2Bloc()..add(FetchEvent()),
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
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
                          return ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              itemCount: 5,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, index) {
                                return Card2(
                                  imgurl:
                                      "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.ruFm7GSP5c_rNOlCglPVBAHaEY%26pid%3DApi&f=1",
                                );
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
      ),
    );
  }
}
