import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/ui/pages/authentication/components/appbar.dart';
import 'package:greenlive/ui/pages/authentication/components/inputfile.dart';
import 'package:greenlive/ui/pages/authentication/sign_up/bloc/sign_up_bloc.dart';

class SingUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: BuildScaffold(),
    );
  }
}

class BuildScaffold extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController nickcontroller = TextEditingController();
  final TextEditingController passwcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpInitial) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("tohome", (route) => false);
        } else if (state is SignUpError) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("tohome", (route) => false);
        } else if (state is LocationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Konum Alınamadı"),
            ),
          );
        } else if (state is LocationSucces) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 1000),
              content: Text("Konum Alındı"),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: AuthAppBar(
              title: "Sign Up",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 50,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RoundedInputField(
                      controller: nickcontroller,
                      hintText: "Kullanıcı Adı",
                      icon: Icons.supervised_user_circle_outlined,
                      ispasw: false,
                    ),
                    RoundedInputField(
                      controller: emailcontroller,
                      hintText: "E-mail",
                      icon: Icons.email,
                      ispasw: false,
                    ),
                    RoundedInputField(
                      controller: passwcontroller,
                      hintText: "Şİfre",
                      icon: Icons.lock,
                      ispasw: true,
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.grey[400].withOpacity(0.8),
                        primary: Colors.black45,
                      ),
                      onPressed: () {
                        BlocProvider.of<SignUpBloc>(context, listen: false)
                            .add(GetLocation());
                      },
                      icon: Icon(Icons.gps_fixed_sharp),
                      label: Text("Konum Al"),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 45,
                      child:
                          (state is LocationLoading) || (state is SignUpLoading)
                              ? Row(
                                children: [
                                  CircularProgressIndicator(),
                                  Text("Konum Alınıyor"),
                                ],
                              )
                              : TextButton(
                                  onPressed: () async {
                                    if (state is LocationSucces) {
                                      BlocProvider.of<SignUpBloc>(context,
                                              listen: false)
                                          .add(
                                        SignUpSubmit(
                                            nickcontroller.text,
                                            emailcontroller.text,
                                            passwcontroller.text),
                                      );
                                    }
                                  },
                                  child: Text("Kayıt Ol"),
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors.green,
                                    primary: Colors.white,
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
