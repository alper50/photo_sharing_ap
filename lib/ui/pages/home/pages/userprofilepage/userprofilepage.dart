import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/ui/pages/home/pages/userprofilepage/bloc/userprofile_bloc.dart';
import 'package:greenlive/ui/widgets/no_connection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    return BlocProvider(
      create: (context) =>
          UserprofileBloc()..add(InitialEvent(arguments["nickname"])),
      child: BlocBuilder<UserprofileBloc, UserprofileState>(
        builder: (context, state) {
          if (state is Loading) {
            return CircularProgressIndicator();
          } else if (state is ConnectionError) {
            return NoConnection();
          } else if (state is SuccesFetch) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(double.infinity, 120),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green,
                            spreadRadius: 5,
                            blurRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(45),
                        ),
                      ),
                    ),
                    Container(),
                    Positioned(
                      // To take AppBar Size only
                      top: 85.0,
                      left: 150.0,
                      right: 150.0,
                      child: AppBar(
                        centerTitle: true,
                        backgroundColor: Colors.white,
                        primary: false,
                        title: Text(
                          "Kullanıcı Adı",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            letterSpacing: 2,
                          ),
                        ),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Center(
                      child: InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.grey[900],
                        borderRadius: BorderRadius.circular(15.0),
                        onTap: () {},
                        child: Container(
                          width: 700,
                          height: 100,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.grey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context).memberdate),
                                  SizedBox(height: 10),
                                  Text(AppLocalizations.of(context).postcount),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Paylaşımlar",
                          style:
                              TextStyle(fontSize: 26, color: Colors.grey[800]),
                        ),
                      ),
                    ),
                    ListView.builder(
                        itemCount: state.data.length, // TODO burası ayarlancak
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              leading: Icon(Icons.list),
                              trailing: Text(
                                "GFG",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15),
                              ),
                              title: Text("List item $index"));
                        }),
                  ],
                ),
              ),
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
