import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/presentation/pages/authentication/components/appbar.dart';
import 'package:greenlive/presentation/pages/authentication/components/inputfile.dart';
import 'package:greenlive/presentation/pages/authentication/components/custombutton.dart';
import 'package:greenlive/presentation/pages/authentication/sign_in/bloc/sign_in_bloc.dart';
import 'package:greenlive/presentation/pages/authentication/sign_up/bloc/sign_up_bloc.dart';

class SingInView extends StatelessWidget {
  final TextEditingController nickcontroller = TextEditingController();
  final TextEditingController passwcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: Buildscaffold(),
    );
  }
}

class Buildscaffold extends StatelessWidget {
  final TextEditingController nickcontroller = TextEditingController();
  final TextEditingController passwcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInSucces) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("tohome", (route) => false);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 500),
          child: AuthAppBar(
            title: "Sign In",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedInputField(
                  controller: nickcontroller,
                  hintText: "Kullanıcı Adı",
                  icon: Icons.supervised_user_circle_outlined,
                  ispasw: false,
                ),
                RoundedInputField(
                  controller: passwcontroller,
                  hintText: "Şİfre",
                  icon: Icons.lock,
                  ispasw: true,
                ),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    if (state is SignInError) {
                      return CustomContainer(
                        child: Text("Bir hata oluştu"),
                        onpressed: () {
                          BlocProvider.of<SignInBloc>(context)
                              .add(TryAgainEvent());
                        },
                      );
                    } else if (state is SignInLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return CustomContainer(
                        child: Text("Giriş Yap"),
                        onpressed: () {
                          BlocProvider.of<SignInBloc>(context).add(
                            LoginEvent(
                                nickname: nickcontroller.text,
                                password: passwcontroller.text),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
