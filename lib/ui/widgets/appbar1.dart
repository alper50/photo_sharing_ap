import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Appbar1 extends StatelessWidget {
  const Appbar1({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text(AppLocalizations.of(context)!.home_page),
            collapsedHeight: 70,
            toolbarHeight: 70,
            centerTitle: true,
            pinned: false,
            floating: false,
            snap: false,
            expandedHeight: 70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
          );
  }
}