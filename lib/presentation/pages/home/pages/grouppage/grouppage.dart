import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/presentation/pages/home/pages/grouppage/subpages/group_member_page.dart';
import 'package:greenlive/presentation/pages/home/pages/grouppage/subpages/group_posts_page.dart';
import 'package:greenlive/presentation/widgets/appbar_grouppage.dart';

import 'bloc/grouppage_bloc.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<bool> toggle = [true, false];

  @override
  Widget build(BuildContext context) {
    final GrouppageBloc bloc = BlocProvider.of<GrouppageBloc>(context);
    return BlocBuilder<GrouppageBloc, GrouppageState>(
      builder: (context, state) {
        return Scaffold(
          bottomSheet: bloc.isShowBottomSheet ? CustomBottomSheet() : null,
          body: BlocBuilder<GrouppageBloc, GrouppageState>(
            builder: (context, state) {
              if (state is InitialLoading || state is GrouppageInitial) {
                return Center(child: CircularProgressIndicator());
              }
              return CustomScrollView(
                slivers: [
                  GroupPageAppbar(),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "6.8.2021",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                AutoSizeText(
                                  " Grup açıklaması " * 5,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ToggleButtons(
                          selectedBorderColor: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          borderWidth: 2,
                          borderColor: Colors.grey,
                          children: [
                            Text("  Paylaşımlar  "),
                            Text("        Üyeler        "),
                          ],
                          isSelected: toggle,
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0; i < toggle.length; i++) {
                                toggle[i] = i == index;
                              }
                            });
                            if (index == 0) {
                              bloc.add(ShowPostEvent());
                            } else {
                              bloc.add(ShowMemberEvent());
                            }
                          },
                        ),
                        BlocBuilder<GrouppageBloc, GrouppageState>(
                          builder: (context, state) {
                            if (state is Loading) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is ShowMemberState) {
                              return GroupMemberPage();
                            }
                            return GroupPostPage();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 30,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: Center(
          child: Text(
            "Gruba Katıl",
            style: TextStyle(
              fontSize: 19,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
