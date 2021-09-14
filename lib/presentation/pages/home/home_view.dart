import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/presentation/pages/home/bloc/homebase_bloc.dart';
import 'package:greenlive/presentation/pages/home/pages/page1/bloc/page1_bloc.dart';
import 'package:greenlive/presentation/pages/home/pages/page1/page_1.dart';
import 'package:greenlive/presentation/pages/home/pages/page2/page_2.dart';
import 'package:greenlive/presentation/pages/home/pages/page3/page_3.dart';
import 'package:greenlive/presentation/pages/home/pages/page4/page_4.dart';
import 'package:greenlive/presentation/widgets/no_connection.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool clickedCentreFAB = false;
  int selectedIndex = 1;
  final List<Widget> _children = [
    BlocProvider(
      create: (context) => Page1Bloc()..add(FetchEvent()),
      child: Page1(),
    ),
    Page2(),
    Page3(),
    Page4(),
  ];
  void updateTabSelection(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomebaseBloc()..add(HomeInitialEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            BlocBuilder<HomebaseBloc, HomebaseState>(
              builder: (context, state) {
                if (state is Loading || state is HomebaseInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ConnectionFound) {
                  return PageTransitionSwitcher(
                    transitionBuilder: (
                      child,
                      animation,
                      secondaryAnimation,
                    ) {
                      return FadeThroughTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        child: child,
                      );
                    },
                    child: _children[selectedIndex],
                  );
                } else if (state is ConnectionError) {
                  if (selectedIndex == 3) {
                    return Page4();
                  } else {
                    return NoConnection();
                  }
                }else{
                  return Container();
                }
              },
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 125),
                //if clickedCentreFAB == true, the first parameter is used. If it's false, the second.
                height: clickedCentreFAB
                    ? MediaQuery.of(context).size.height
                    : 10.0,
                width: clickedCentreFAB
                    ? MediaQuery.of(context).size.height
                    : 10.0,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(clickedCentreFAB ? 0.0 : 300.0),
                    color: Colors.black),
                onEnd: () {
                  setState(() {
                    clickedCentreFAB = !clickedCentreFAB;
                  });
                  Navigator.pushNamed(context, "tocamera");
                },
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          isExtended: false,
          onPressed: () {
            setState(() {
              clickedCentreFAB = !clickedCentreFAB;
            });
          },
          tooltip: "Take Photo",
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Icon(Icons.camera_alt_outlined),
          ),
          elevation: 4.0,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    updateTabSelection(0);
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.home,
                    //darken the icon if it is selected or else give it a different color
                    color: selectedIndex == 0
                        ? Colors.green.shade900
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    updateTabSelection(1);
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.list,
                    color: selectedIndex == 1
                        ? Colors.green.shade900
                        : Colors.grey.shade400,
                  ),
                ),
                //to leave space in between the bottom app bar items and below the FAB
                SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  onPressed: () {
                    updateTabSelection(2);
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.map_outlined,
                    color: selectedIndex == 2
                        ? Colors.green.shade900
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    updateTabSelection(3);
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.settings,
                    color: selectedIndex == 3
                        ? Colors.green.shade900
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          //to add a space between the FAB and BottomAppBar
          shape: CircularNotchedRectangle(),
          //color of the BottomAppBar
          color: Colors.white,
        ),
      ),
    );
  }
}
