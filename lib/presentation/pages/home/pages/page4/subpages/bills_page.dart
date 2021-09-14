import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Faturalandırma"),
      ),
      body: Container(
        child: Center(
          child: AutoSizeText(
            "Şu anda herhangi bir ödemeniz yoktur",
            maxFontSize: 26,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
