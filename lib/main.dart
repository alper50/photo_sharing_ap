import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greenlive/presentation/pages/authentication/sign_in/sign_in_view.dart';
import 'package:greenlive/presentation/pages/authentication/sign_up/sign_up_view.dart';
import 'package:greenlive/presentation/pages/authentication/sign_view.dart';
import 'package:greenlive/presentation/pages/creategrouppage/create_group_page.dart';
import 'package:greenlive/presentation/pages/home/home_view.dart';
import 'package:greenlive/presentation/pages/home/pages/camerapage/camera_view.dart';
import 'package:greenlive/presentation/pages/home/pages/grouppage/bloc/grouppage_bloc.dart';
import 'package:greenlive/presentation/pages/home/pages/grouppage/grouppage.dart';
import 'package:greenlive/presentation/pages/home/pages/page4/my_posts_page/my_posts_page.dart';
import 'package:greenlive/presentation/pages/home/pages/page4/subpages/bills_page.dart';
import 'package:greenlive/presentation/pages/home/pages/page4/subpages/my_account_page.dart';
import 'package:greenlive/presentation/pages/home/pages/uploadimagepage/uploadimagepage.dart';
import 'package:greenlive/presentation/pages/home/pages/userprofilepage/userprofilepage.dart';
import 'package:greenlive/presentation/pages/splash/splash_view.dart';
import 'package:greenlive/presentation/widgets/themedata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightheme,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'touserprofile':
            return _createRoute(
              UserProfile(),
            );
            break;
          case 'togrouppage':
            return _createRoute(
              BlocProvider(
                create: (context) => GrouppageBloc()..add(ShowInitialPostEvent()),
                child: GroupPage(),
              ),
            );
            break;
          case 'tohomeview':
            return _createRoute(
              HomeView(),
            );
            break;
          case 'tobillspage':
            return _createRoute(
              BillsPage(),
            );
            break;
          case 'tomyaccount':
            return _createRoute(
              MyAccount(),
            );
            break;
          case 'tomypostspage':
            return _createRoute(
              MyPostsPage(),
            );
            break;
          default:
            return _createRoute(Container());
        }
      },
      routes: {
        "tosignview": (context) => SignView(),
        "tosigninview": (context) => SingInView(),
        "tosignupview": (context) => SingUpView(),
        "tohome": (context) => HomeView(),
        "tocamera": (context) => CameraScreen(),
        "touploadposts": (context) => UploadPage(),
        "tocreategrouppage": (context) => CreateGroup(),
      },
      home: Splash(),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
