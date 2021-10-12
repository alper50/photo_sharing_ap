import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenlive/core/config/util/l10n/l10n.dart';
import 'package:greenlive/main_bloc/main_bloc.dart';
import 'package:greenlive/ui/widgets/appbar4.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomAppBar4(),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          sliver: SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(AppLocalizations.of(context).usersettings),
                  ),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.green,
                          ),
                          title: Text(AppLocalizations.of(context).myaccount),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () =>
                              Navigator.pushNamed(context, 'tomyaccount'),
                        ),
                        BuildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.receipt_long_outlined,
                            color: Colors.green,
                          ),
                          title: Text(AppLocalizations.of(context).bills),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () =>
                              Navigator.pushNamed(context, 'tobillspage'),
                        ),
                        BuildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.mms_sharp,
                            color: Colors.green,
                          ),
                          title: Text(AppLocalizations.of(context).myposts),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () =>
                              Navigator.pushNamed(context, 'tomypostspage'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(AppLocalizations.of(context).appsettings),
                  ),
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.notifications,
                            color: Colors.green,
                          ),
                          title: Text(AppLocalizations.of(context).notification),
                          onTap: () {},
                        ),
                        BuildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.language,
                            color: Colors.green,
                          ),
                          title: Text(AppLocalizations.of(context).lang),
                          onTap: () => _chooselang(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _chooselang(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(AppLocalizations.of(context).chooselang),
            children: L10n.all
                .map(
                  (e) => RadioTile(
                    e: e,
                    context: context,
                  ),
                )
                .toList(),
          );
        });
  }
}

class RadioTile extends StatefulWidget {
  final Locale e;
  final BuildContext context;
  RadioTile({Key key, this.e, this.context}) : super(key: key);

  @override
  State<RadioTile> createState() => _RadioTileState();
}

class _RadioTileState extends State<RadioTile> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      selected: widget.e.languageCode==context.read<MainBloc>().locale.languageCode ? true : false,
      value: widget.e.toString(),
      groupValue: 1,
      toggleable: true,
      onChanged: (data) {
        setState(() {
          selected = !selected;
        });
        context.read<MainBloc>().add(ChangeLanguage(selectedLanguage: widget.e));
        

Navigator.of(context).pop(false);

      },
      title: widget.e.languageCode == 'en' ? Text('English') : Text('Türkçe'),
    );
  }
}

class BuildDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
