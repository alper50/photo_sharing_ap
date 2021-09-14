import 'package:flutter/material.dart';

class GroupMemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.grey[200],
                trailing: CircleAvatar(
                  child: Text("15"),
                ),
                horizontalTitleGap: 25,
                title: Text("birinci üye"),
                subtitle: Text("7.8.2021"),
                onTap: () {},
              ),
            ),
          );
        });
  }
}
