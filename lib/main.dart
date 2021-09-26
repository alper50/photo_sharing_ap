import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greenlive/core/config/util/l10n/l10n.dart';
import 'package:greenlive/main_bloc/main_bloc.dart';
import 'package:greenlive/ui/pages/authentication/sign_in/sign_in_view.dart';
import 'package:greenlive/ui/pages/authentication/sign_up/sign_up_view.dart';
import 'package:greenlive/ui/pages/authentication/sign_view.dart';
import 'package:greenlive/ui/pages/creategrouppage/create_group_page.dart';
import 'package:greenlive/ui/pages/home/home_view.dart';
import 'package:greenlive/ui/pages/home/pages/camerapage/camera_view.dart';
import 'package:greenlive/ui/pages/home/pages/grouppage/bloc/grouppage_bloc.dart';
import 'package:greenlive/ui/pages/home/pages/grouppage/grouppage.dart';
import 'package:greenlive/ui/pages/home/pages/page4/my_posts_page/my_posts_page.dart';
import 'package:greenlive/ui/pages/home/pages/page4/subpages/bills_page.dart';
import 'package:greenlive/ui/pages/home/pages/page4/subpages/my_account_page.dart';
import 'package:greenlive/ui/pages/home/pages/uploadimagepage/uploadimagepage.dart';
import 'package:greenlive/ui/pages/home/pages/userprofilepage/userprofilepage.dart';
import 'package:greenlive/ui/pages/splash/splash_view.dart';
import 'package:greenlive/ui/widgets/themedata.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  runApp(BlocProvider(
    create: (context) => MainBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.lightheme,
          locale: state.props.first,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
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
                    create: (context) =>
                        GrouppageBloc()..add(ShowInitialPostEvent()),
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
      },
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
