import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/ui/pages/home/bloc/homebase_bloc.dart';
import 'package:lottie/lottie.dart';

class NoConnection extends StatelessWidget {
  final bool? blockname;

  const NoConnection({Key? key, this.blockname}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.height * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: LottieBuilder.asset("assets/no_connection.json"),
                ),
                SizedBox(
                  height: 25,
                ),
                AutoSizeText("İnternet bağlantınızı kontrol edin"),
                SizedBox(
                  height: 25,
                ),
                TextButton(
                  onPressed: () {
                    if(blockname!){
                       BlocProvider.of<HomebaseBloc>(context)
                        .add(RefreshConnectionEvent());
                    }
                  },
                  child: BlocBuilder<HomebaseBloc, HomebaseState>(
                    builder: (context, state) {
                      if (state is Loading) {
                        return CircularProgressIndicator();
                      } else {
                        return Text("Yeniden Dene");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
